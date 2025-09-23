# laraochan's nix-darwin

## ⚠️トラブルシューティングガイド⚠️

- **GUIアプリケーションはenvironment.systemPackages**
  - home.packagesにGUIアプリケーションを入れてはいけない
  - nix-darwin + home-manager環境だと現状home-managerはPATHに入るだけなのでGUIアプリケーションはApplication配下に入らない
  - 補足: NixOSの時はGNOMEやKDEは.desktopの仕組みを持っていたのでhome.packages経由でも認識するがmacOSはないためだと思われる

- **Could not find suitable profile directory, tried /home/laraochan/.local/state/home-manager/profiles and /nix/var/nix/profiles/per-user/shyim**
  - マルチユーザーインストールでNixを入れると`/home/laraochan/.local/state/home-manager/profiles`を作成する際に`.local`などをrootで作ってしまうみたい
  - 現状だと`chown -R laraochan:staff ~/.local`をエラーが出た際に手動実行すればいい