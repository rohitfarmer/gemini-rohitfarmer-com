rsync -e ssh \
            --archive \
            --compress \
            --delete \
            --exclude '*.git*' \
            --verbose \
            ./capsule/ gemini@rohitfarmer.com:/home/gemini/capsule/
