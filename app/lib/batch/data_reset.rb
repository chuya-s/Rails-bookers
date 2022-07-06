class Batch::DataReset
  def self.data_reset
    Book.destroy_all
    p "投稿を全て削除しました"
  end
end