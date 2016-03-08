_android_maven_latest_url(){
    local latest_version_code
    latest_version_code=$(curl -s http://maven.apache.org/download.cgi | s -o '(?<=Apache\ Maven\ ).*?(?=\ is\ the\ latest\ release\ and\ recommended\ version\ for\ all\ users\.)')
    _module_config_write 'android' 'maven' $latest_version_code
    echo "http://mirrors.hust.edu.cn/apache/maven/maven-3/$latest_version_code/binaries/apache-maven-$latest_version_code-bin.tar.gz"
}

export PATH="$MY_BIN/apache-maven-3.3.3/bin:$PATH"
