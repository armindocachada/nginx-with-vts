#!/bin/bash
mkdir -p /nginx
cd /nginx
apt-get source nginx=${NGINX_VERSION}-1
mkdir -p nginx-${NGINX_VERSION}/debian/modules

cd /nginx/nginx-${NGINX_VERSION}
wget -O vts.tar.gz https://github.com/vozlt/nginx-module-vts/archive/v${NGINX_VTS_VERSION}.tar.gz
tar -xf vts.tar.gz
ls -alh .
pwd
sed -i "0,/CFLAGS\=\\\"\\\"/{/CFLAGS\=\\\"\\\"/ s/$/ --add-module=\/nginx\/nginx-${NGINX_VERSION}\/nginx-module-vts-${NGINX_VTS_VERSION} ${PS_NGX_EXTRA_FLAGS} /}" /nginx/nginx-${NGINX_VERSION}/debian/rules

sed -i "s/CFLAGS\=\\\"\\\"/CFLAGS\=\\\"-Wno-missing-field-initializers\\\"/" /nginx/nginx-${NGINX_VERSION}/debian/rules


dpkg-buildpackage -b

#mkdir -p /nginx-dist
#cp /nginx/*.deb /nginx-dist/