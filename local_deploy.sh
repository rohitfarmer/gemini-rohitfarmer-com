rsync       --archive \
            --compress \
            --delete \
            --exclude '*.git*' \
            --verbose \
            --no-owner \
            --no-group \
            ./capsule/ /home/gemini/capsule/
