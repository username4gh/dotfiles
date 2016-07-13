_android_maven_latest_url(){
    local latest_version_code
    latest_version_code=$(curl -s https://maven.apache.org/download.cgi | s -o '(?<=Apache\ Maven\ ).*?(?=\ is\ the\ latest\ release\ and\ recommended\ version\ for\ all\ users\.)')
    _conf_write 'maven' $latest_version_code
    echo "http://mirrors.hust.edu.cn/apache/maven/maven-3/$latest_version_code/binaries/apache-maven-$latest_version_code-bin.tar.gz"
}

export PATH="$(_autodetect_bin 'apache-maven-.*')/bin:$PATH"
