class LinebotController < ApplicationController
  require 'line/bot' # gem 'line-bot-api'
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new {|config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)

    events.each {|event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          e_msg = event.message['text']

          if /写真/ =~ e_msg
            # 写真ほしい時の処理
            set_images
            message = {
                type: 'image',
                originalContentUrl: "https://sudachi-nyanko.herokuapp.com/#{@images.sample.image.url}",
                previewImageUrl: "https://sudachi-nyanko.herokuapp.com/#{@images.sample.image.thumb.url}",
            }
            return client.reply_message(event['replyToken'], message)
          end
          replay_msg_blank = ReplayMsg.where(react_msg: e_msg)
          if !!replay_msg_blank.blank?
            # 完全一致してなかった時
            msgs = ReplayMsg.all
            msgs.each do |msg|
              r_msg_array = msg.react_including_msg.split(' ')
              r_msg_array.each do |r_msg_a|
                r_msg = Regexp.new(r_msg_a)
                if r_msg =~ e_msg
                  msg_array = msg.replay.split(' ')
                  message = {
                      type: 'text',
                      text: msg_array.sample
                  }
                  return client.reply_message(event['replyToken'], message)
                end
              end
            end
          else
            # 完全一致していた時
            msg_array = replay_msg_blank.first.replay.split(' ')
            message = {
                type: 'text',
                text: msg_array.sample
            }
            return client.reply_message(event['replyToken'], message)
          end
        end
      end
    }

    head :ok
  end

  private

  def set_images
    @images ||= SudachiImage.all
  end
end
