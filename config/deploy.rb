# capistranoの出力がカラーになる
require 'capistrano_colors'

# cap deploy時に自動で bundle install が実行される
require "bundler/capistrano"
set :bundle_flags, "--quiet"



# sshでログインするユーザ
set :user,          "test"
# ssh 公開鍵設定
set :ssh_options, :port=>22, :forward_agent=>false
ssh_options[:keys] = ["'~/.ssh/id_rsa'"]
# コマンド実行時にsudoをつけるか
set :use_sudo, false



# アプリケーション名
set :application, "taka"
# subverion, git, mercurial, cvs, bzrなど
set :scm ,:git
#gitリポジトリ
set :repository,  "git@github.com:useiichi/taka.git"
#gitブランチ名
set :branch, :master
# どういう方式でデプロイするか
# copy デプロイ元でソースを最新化してからデプロイ先にコピー
# checkout デプロイ先に接続した後、scmに応じたcheckoutコマンドを実行する
set :deploy_via , :copy
# deploy先ディレクトリ
set :deploy_to, "/var/www/#{application}"


set :rails_env, "production"



# デプロイサーバ定義
role :web, "www5183ui.sakura.ne.jp"
role :app, "www5183ui.sakura.ne.jp"
role :db, "www5183ui.sakura.ne.jp", :primary => true


# Unicorn用に起動/停止タスクを変更
namespace :deploy do
  task :start, :roles => :app do
    run "cd #{current_path}; #{sudo} bundle exec unicorn_rails -c config/unicorn.rb -E #{rails_env} -D -p 13005 --path /taka"
  end
  task :restart, :roles => :app do
    if File.exist? "/tmp/unicorn_#{application}.pid"
      run "kill -s USR2 `cat /tmp/unicorn_#{application}.pid`"
    end
  end
  task :stop, :roles => :app do
    run "#{sudo} kill -s QUIT `cat /var/run/unicorn/unicorn_#{application}.pid`"
  end
end

