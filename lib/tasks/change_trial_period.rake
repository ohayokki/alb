desc "Update shop status from 'trial' to 'free' for those expired"
task change_trial_status: :environment do
  Shop.where(status: 'お試し有料掲載')
      .where('trial_start_date <= ?', 3.months.ago)
      .update_all(status: '無料掲載')

  puts "ショップのステータスを更新しました。"
end
