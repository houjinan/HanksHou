From ruby:2.3.3

# 来指代容器中的 rails 程序放的目录
ENV RAILS_ROOT /var/www/hankshou

# 创建 rails 程序目录和程序运行所需要的 pids 的目录
RUN mkdir -p $RAILS_ROOT/tmp/pids

# RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
# COPY docker/sources.list /etc/apt/sources.list

# RUN apt-get update -qq && apt-get install -y nodejs
COPY docker/node-v10.15.3-linux-x64.tar.gz /opt/
RUN tar -xf /opt/node-v10.15.3-linux-x64.tar.gz -C /opt/

#RUN ln -s /opt/node-v10.15.3-linux-x64/bin/node /usr/local/bin/node
#RUN ln -s /opt/node-v10.15.3-linux-x64/bin//npm /usr/local/bin/npm

ENV NODE_HOME=/opt/node-v10.15.3-linux-x64
ENV PATH=$NODE_HOME/bin:$PATH
ENV NODE_PATH=/opt/node-v10.15.3-linux-x64/lib/node_modules

WORKDIR /var/www/hankshou
COPY . .
#赋写权限
RUN rm -rf /var/www/hankshou/.git/
RUN chmod a+x /var/www/hankshou/run-entrypoint.sh
ENTRYPOINT ["sh","/var/www/hankshou/run-entrypoint.sh"]



