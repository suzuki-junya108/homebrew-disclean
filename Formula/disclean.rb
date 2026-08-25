class Disclean < Formula
  desc "macOS のディスクを、消す前に重さで見せて片づけるツール（隔離庫つき）"
  homepage "https://github.com/suzuki-junya108/disclean"
  url "https://github.com/suzuki-junya108/disclean/releases/download/v1.1.0/disclean-1.1.0-macos-universal.tar.gz"
  sha256 "a174d9f75138f312a6efce315559e1d49199a9516b130c71055c2d3632c5f01d"
  license "MIT"
  version "1.1.0"

  depends_on macos: :sonoma

  def install
    # 同梱ルールはリソースバンドルに入っているため、実行ファイルと同じ場所に置く。
    libexec.install "disclean", "Disclean_DiscleanKit.bundle"
    bin.write_exec_script libexec/"disclean"
    doc.install "README.md", "LICENSE"
  end

  def caveats
    <<~EOS
      使い方:
        disclean doctor   環境を確認する
        disclean scan     読み取りだけで、何がどれだけ空けられるか調べる
        disclean apply    選んだものを隔離庫へ移す（7 日は undo で戻せます）

      掃除ルールの更新は署名付きで配られます。止めるときは disclean update --off
    EOS
  end

  test do
    assert_match "disclean #{version}", shell_output("#{bin}/disclean --version")
    assert_match "USAGE:", shell_output("#{bin}/disclean --help")
  end
end
