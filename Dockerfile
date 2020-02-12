FROM nginx:mainline-alpine
RUN rm /etc/nginx/conf.d/*
ADD helloworld.conf /etc/nginx/conf.d/
ADD index.html /usr/share/nginx/html/
ADD run.sh /bin/
RUN chmod +x /bin/run.sh
EXPOSE 80
ENTRYPOINT ["/bin/run.sh"]
