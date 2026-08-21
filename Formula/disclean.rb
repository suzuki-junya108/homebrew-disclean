class Disclean < Formula
  desc "macOS のディスクを、消す前に重さで見せて片づけるツール（隔離庫つき）"
  homepage "https://github.com/suzuki-junya108/disclean"
  url "https://github.com/suzuki-junya108/disclean/releases/download/v0.1.5/disclean-0.1.5-macos-universal.tar.gz"
  sha256 "f974e7e7c839a945a32e47ad07b821df239d68de912bd1e33815e1c1c9bece64"
  license "MIT"
  version "0.1.5"

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
