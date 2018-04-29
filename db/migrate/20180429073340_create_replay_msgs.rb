class CreateReplayMsgs < ActiveRecord::Migration[5.1]
  def change
    create_table :replay_msgs do |t|
      t.string :react_msg
      t.string :react_including_msg
      t.string :replay
      t.timestamps
    end
  end
end
