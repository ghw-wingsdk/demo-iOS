#!/bin/zsh
set -euo pipefail

#####################################
# 自行修改下面这几项配置
#####################################

# 工程根目录（一般不用改）
PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"

# 如果你是 .xcworkspace（通常 Pod 项目都是），填 workspace 名
# 比如 Demo.xcworkspace
WORKSPACE_NAME="WADemo.xcworkspace"

# Scheme 名（和 Xcode 里运行/打包用的一致）
SCHEME_NAME="WADemo"

# Build 配置
CONFIGURATION="Release"

# 主 App 的 Info.plist 路径（相对项目根目录）
INFO_PLIST_PATH="WADemo/Info.plist"

# xcodebuild 导出用的 ExportOptions.plist 路径
# 这个文件你自己在 Xcode 导出一次 ipa 后可以保存一份
EXPORT_OPTIONS_PLIST="$PROJECT_ROOT/ExportOptions.plist"

# 打包输出根目录
OUTPUT_DIR="$PROJECT_ROOT/BuildOutputs"

#####################################
# 下面一般不用改
#####################################

cd "$PROJECT_ROOT"

echo "==> 1. pod update"
pod update

echo "==> 2. 版本号（CFBundleVersion）+1"
INFO_PLIST="$PROJECT_ROOT/$INFO_PLIST_PATH"

# 如果没有 CFBundleVersion，则先创建一个
if ! /usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$INFO_PLIST" >/dev/null 2>&1; then
  echo "CFBundleVersion 不存在，先创建为 0"
  /usr/libexec/PlistBuddy -c "Add :CFBundleVersion string 0" "$INFO_PLIST"
fi

# 再读取当前 build 号
CURRENT_BUILD=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$INFO_PLIST")
if ! [[ "$CURRENT_BUILD" =~ ^[0-9]+$ ]]; then
  echo "当前 CFBundleVersion 非数字（$CURRENT_BUILD），将从 0 开始"
  CURRENT_BUILD=0
fi
NEXT_BUILD=$((CURRENT_BUILD + 1))
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $NEXT_BUILD" "$INFO_PLIST"
echo "CFBundleVersion: $CURRENT_BUILD -> $NEXT_BUILD"

echo "==> 3. xcodebuild archive"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_DIR="$OUTPUT_DIR/archives"
IPA_DIR="$OUTPUT_DIR/ipas/$TIMESTAMP"

mkdir -p "$ARCHIVE_DIR"
mkdir -p "$IPA_DIR"

ARCHIVE_PATH="$ARCHIVE_DIR/${SCHEME_NAME}_${TIMESTAMP}.xcarchive"

xcodebuild \
  clean \
  -workspace "$WORKSPACE_NAME" \
  -scheme "$SCHEME_NAME" \
  -configuration "$CONFIGURATION"

xcodebuild \
  archive \
  -workspace "$WORKSPACE_NAME" \
  -scheme "$SCHEME_NAME" \
  -configuration "$CONFIGURATION" \
  -archivePath "$ARCHIVE_PATH"

echo "==> 4. 导出 ipa 到文件夹：$IPA_DIR"
xcodebuild \
  -exportArchive \
  -archivePath "$ARCHIVE_PATH" \
  -exportOptionsPlist "$EXPORT_OPTIONS_PLIST" \
  -exportPath "$IPA_DIR"

echo "==> 完成！生成的 ipa 文件在：$IPA_DIR"