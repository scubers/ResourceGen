
# xcrun --sdk macosx /usr/bin/swift "../ResourceGen/Script/main.swift" --dir=ResourceGen/resource.bundle --output=StyleOC+Mutable.swift --type=mutable --objc --bundleKey=resource --objcKey=OC
../ResourceGen/Script/main --dir=ResourceGen/resource.bundle --output=StyleOC+Mutable.swift --type=mutable --objc --bundleKey=resource --objcKey=OC

xcrun --sdk macosx /usr/bin/swift "$SRCROOT/../ResourceGen/Script/main.swift" --dir=$SRCROOT/ResourceGen/resource.bundle --output=$SRCROOT/ResourceGen/Style+Static.swift --type=static --bundleKey=resource
xcrun --sdk macosx /usr/bin/swift "$SRCROOT/../ResourceGen/Script/main.swift" --dir=$SRCROOT/ResourceGen/resource.bundle --output=$SRCROOT/ResourceGen/StyleOC+Static.swift --type=static --objc --bundleKey=resource --objcKey=OC
xcrun --sdk macosx /usr/bin/swift "$SRCROOT/../ResourceGen/Script/main.swift" --dir=$SRCROOT/ResourceGen/resource.bundle --output=$SRCROOT/ResourceGen/Style+Mutable.swift --type=mutable --bundleKey=resource
xcrun --sdk macosx /usr/bin/swift "$SRCROOT/../ResourceGen/Script/main.swift" --dir=$SRCROOT/ResourceGen/resource.bundle --output=$SRCROOT/ResourceGen/StyleOC+Mutable.swift --type=mutable --objc --bundleKey=resource --objcKey=OC


"$SRCROOT/../ResourceGen/Script/main" --dir=$SRCROOT/ResourceGen/resource.bundle --output=$SRCROOT/ResourceGen/Style+Static.swift --type=static --bundleKey=resource
"$SRCROOT/../ResourceGen/Script/main" --dir=$SRCROOT/ResourceGen/resource.bundle --output=$SRCROOT/ResourceGen/StyleOC+Static.swift --type=static --objc --bundleKey=resource --objcKey=OC
"$SRCROOT/../ResourceGen/Script/main" --dir=$SRCROOT/ResourceGen/resource.bundle --output=$SRCROOT/ResourceGen/Style+Mutable.swift --type=mutable --bundleKey=resource
"$SRCROOT/../ResourceGen/Script/main" --dir=$SRCROOT/ResourceGen/resource.bundle --output=$SRCROOT/ResourceGen/StyleOC+Mutable.swift --type=mutable --objc --bundleKey=resource --objcKey=OC
