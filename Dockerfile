FROM        m41d/tdd:base

COPY        ./ /srv/projects

WORKDIR     /srv/projects/superlists
RUN         python3 ./manage.py collectstatic --noinput

RUN         rm -rf /etc/nginx/sites-enabled/* && \
            rm -rf /etc/nginx/sites-available/* && \
            cp -f /srv/projects/superlists/.config/app.nginx /etc/nginx/sites-available/ && \
            ln -sf /etc/nginx/sites-available/app.nginx /etc/nginx/sites-enabled/app.nginx

RUN         cp -f /srv/projects/superlists/.config/supervisord.conf /etc/supervisor/conf.d/
CMD         supervisord -n