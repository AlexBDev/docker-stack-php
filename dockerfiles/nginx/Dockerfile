FROM nginx:1.13


ARG DSP_USER_USERNAME
ARG DSP_USER_UID
ARG DSP_USER_GID


# Fix permission between host and guest
RUN addgroup --gid $DSP_USER_GID $DSP_USER_USERNAME
RUN adduser --gecos "" --disabled-password --gid $DSP_USER_GID --uid $DSP_USER_UID $DSP_USER_USERNAME

RUN sed -i -e "s/user\s\+nginx;/user $DSP_USER_USERNAME;/" /etc/nginx/nginx.conf


CMD ["nginx", "-g", "daemon off;"]
