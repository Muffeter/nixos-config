FROM docker.son5mu.win/node
COPY . /root/app/
WORKDIR /root/app
RUN npm i --registry https://npmreg.proxy.ustclug.org/ && npm run build

FROM docker.son5mu.win/nginx
COPY --from=0 /root/app/dist /www/app
CMD ["nginx"]
