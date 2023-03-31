#!/bin/sh
set -e

# All args after the second are libraries
# pass the resulting library as the first libraries_to_merge
libraries_to_merge=("${@:3}")
bundled_library_name=${libraries_to_merge[0]}
echo "Libraries to merge into a single binary : ${libraries_to_merge[*]}"
echo "Bundled library name : ${bundled_library_name}"
cd $2
pwd

libtool="/usr/bin/libtool"
folders=(ios-arm64 ios-arm64_x86_64-simulator)

for folder in ${folders[*]}
do
    endlibrary="$1/${folder}/${bundled_library_name}.framework/${bundled_library_name}"

    archs="arm64 x86_64"
    if [ "$folder" = "ios-arm64" ]; then
        archs="arm64"
    fi

    for library in ${libraries_to_merge[*]}
    do
        library_path=${library}.xcframework/${folder}/${library}.framework/${library}
        echo "Merging : ${library_path}"
        lipo -info $library_path
        
        # Extract individual architectures for this library
        archlist=($archs)
        echo "Array length: ${#archlist[@]}"
        if [ ${#archlist[@]} -gt 1 ]; then
            for arch in ${archs[*]}
            do
                lipo -extract $arch $library_path -o ${library_path}_${arch}.a
            done
        else #[ ${#archlist[@]}==1 ]
            cp $library_path ${library_path}_${archs[0]}.a
        fi
    done

    # Combine results of the same architecture into a library for that architecture
    source_combined=""
    for arch in ${archs[*]}
    do
        source_libraries=""
        
        for library in ${libraries_to_merge[*]}
        do
            library_path=${library}.xcframework/${folder}/${library}.framework/${library}
            source_libraries="${source_libraries} ${library_path}_${arch}.a"
        done
        all_libs_prefix="all_libs"
        $libtool -static ${source_libraries} -o "${all_libs_prefix}_${arch}.a"
        source_combined="${source_combined} ${all_libs_prefix}_${arch}.a"
        
        # Delete intermediate files
        rm ${source_libraries}
    done

    #remove $1 if exists
    rm $endlibrary

    # Merge the combined library for each architecture into a single fat binary
    lipo -create $source_combined -o $endlibrary

    # Delete intermediate files
    rm ${source_combined}


    # Show info on the output library as confirmation
    echo "Combination complete."
    lipo -info $endlibrary
done
