cd ${TRAVIS_BUILD_DIR}/
terraform workspace select ${1}
terraform ${2}