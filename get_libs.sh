mkdir -p libs
rm -rf libs/*
lddtree ./run/cans | awk '{print $3}' | tail -n +2 | grep -v '^$' | while read lib; do
    cp -P "$lib" libs/
    # Resolve the real path if it's a symbolic link
    real_path=$(readlink -f "$lib")
    # Copy the resolved file to the libs directory
    if [ -n "$real_path" ]; then
	cp -v "$real_path" libs/
    fi
done
chmod 755 libs/*
