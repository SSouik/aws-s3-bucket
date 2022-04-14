# Get the current version of the Package
version=$(grep '"version":' version.json | cut -d\" -f4)

echo "Creating release for v${version}"
token=$1

# Create the release
curl \
    -X POST \
    -u "SSouik:${token}" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/SSouik/aws-s3-bucket/releases \
    -d "{\"tag_name\":\"v${version}\",\"name\":\"v${version}\",\"generate_release_notes\":true}\""