class LinebotController < ApplicationController
  require 'line/bot' # gem 'line-bot-api'
  require 'mini_magick'

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new {|config|
      ENV["LINE_CHANNEL_SECRET"] = "77633b13c37cd1e9b3484ca39fa9b54c"
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      ENV["LINE_CHANNEL_TOKEN"] = "hqxe2FJXoS5KHa8sawUMB1tF0KPYKpUYpsUOCuaq1os8IJQ6hRDk8PMkCDw/j++qtJcKXx04cxMVkbK3pyfVF6y9TiUbMESCE3ElldOKAAWYM4BrtfUz4w8zyKjRVhWO5wjoD8XkXfLAQe5hP20RmgdB04t89/1O/w1cDnyilFU="
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do
        'Bad Request'
      end
    end

    events = client.parse_events_from(body)

    events.each {|event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          e_msg = event.message['text']
          # # if /写真/ =~ e_msg
          # #   pp set_images.sample
          # #   message = {
          # #       type: 'image',
          # #       originalContentUrl: "public/sudachi/#{@images.sample}",
          # #       previewImageUrl: "public/sudachi/#{@images.sample}",
          # #   }
          # #   pp message
          # #   return client.reply_message(event['replyToken'], message)
          # end
          boolean = ReplayMsg.where(react_msg: e_msg)
          if !!boolean.blank?
            msgs = ReplayMsg.all
            msgs.each do |msg|
              r_msg = Regexp.new(msg.react_including_msg)
              if r_msg =~ e_msg
                msg_array = msg.replay.split(' ')
                message = {
                    type: 'text',
                    text: msg_array.sample
                }
                return client.reply_message(event['replyToken'], message)
              end
            end
          else
            msg_array = boolean.first.replay.split(' ')
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

  # def set_images
  #   if !!@images ||= []
  #     @images << "DbSw0cPUQAAdQXQ.jpg"
  #     @images << "DMWO5NOVQAAY0Up.jpg"
  #     @images << "DMWP2QbVoAEuiTf.jpg"
  #     @images << "DMWP2QGUEAEHh11.jpg"
  #     @images << "DN7liM8UMAAGISh.jpg"
  #     @images << "DPFRRO0V4AIq_Qo.jpg"
  #     @images << "DPJs4gCVwAUeCvO.jpg"
  #     @images << "DPKLo-CVwAA96vS.jpg"
  #     @images << "DRj_JP0U8AAck9g.jpg"
  #     @images << "DRj_JP0UIAA-ArM.jpg"
  #     @images << "DRj_JP0VoAEJ8zE.jpg"
  #     @images << "DRj_JP6V4AA1XQ8.jpg"
  #     @images << "DRZQ_boU8AAukP6.jpg"
  #     @images << "DRZQ_F1VwAAL09a.jpg"
  #     @images << "DRZQ_FTUIAAGWXY.jpg"
  #     @images << "DRZQ_MbV4AEwU8D.jpg"
  #     @images << "DVKQiWYU0AA3KIm.jpg"
  #     @images << "DWmrOm2U8AAXdjW.jpg"
  #     @images << "DWmrOnbV4AAcxyq.jpg"
  #     @images << "DWmrOncU8AAyzbp.jpg"
  #     @images << "DWmrOndVMAAt_nC.jpg"
  #     @images << "すだち成長記録_180429_0001.jpg"
  #     @images << "すだち成長記録_180429_0002.jpg"
  #     @images << "すだち成長記録_180429_0003.jpg"
  #     @images << "すだち成長記録_180429_0004.jpg"
  #     @images << "すだち成長記録_180429_0005.jpg"
  #     @images << "すだち成長記録_180429_0006.jpg"
  #     @images << "すだち成長記録_180429_0007.jpg"
  #     @images << "すだち成長記録_180429_0008.jpg"
  #     @images << "すだち成長記録_180429_0009.jpg"
  #     @images << "すだち成長記録_180429_0012.jpg"
  #     @images << "すだち成長記録_180429_0013.jpg"
  #     @images << "すだち成長記録_180429_0014.jpg"
  #     @images << "すだち成長記録_180429_0015.jpg"
  #     @images << "すだち成長記録_180429_0016.jpg"
  #     @images << "すだち成長記録_180429_0017.jpg"
  #     @images << "すだち成長記録_180429_0018.jpg"
  #     @images << "すだち成長記録_180429_0019.jpg"
  #     @images << "すだち成長記録_180429_0020.jpg"
  #     @images << "すだち成長記録_180429_0021.jpg"
  #     @images << "すだち成長記録_180429_0024.jpg"
  #     @images << "すだち成長記録_180429_0025.jpg"
  #     @images << "すだち成長記録_180429_0026.jpg"
  #     @images << "すだち成長記録_180429_0027.jpg"
  #     @images << "すだち成長記録_180429_0028.jpg"
  #     @images << "すだち成長記録_180429_0029.jpg"
  #     @images << "すだち成長記録_180429_0030.jpg"
  #     @images << "すだち成長記録_180429_0031.jpg"
  #     @images << "すだち成長記録_180429_0033.jpg"
  #     @images << "すだち成長記録_180429_0034.jpg"
  #     @images << "すだち成長記録_180429_0035.jpg"
  #     @images << "すだち成長記録_180429_0036.jpg"
  #     @images << "すだち成長記録_180429_0037.jpg"
  #     @images << "すだち成長記録_180429_0038.jpg"
  #     @images << "すだち成長記録_180429_0039.jpg"
  #     @images << "すだち成長記録_180429_0040.jpg"
  #     @images << "すだち成長記録_180429_0041.jpg"
  #     @images << "すだち成長記録_180429_0042.jpg"
  #     @images << "すだち成長記録_180429_0043.jpg"
  #     @images << "すだち成長記録_180429_0044.jpg"
  #     @images << "すだち成長記録_180429_0045.jpg"
  #     @images << "すだち成長記録_180429_0046.jpg"
  #     @images << "すだち成長記録_180429_0047.jpg"
  #     @images << "すだち成長記録_180429_0048.jpg"
  #     @images << "すだち成長記録_180429_0049.jpg"
  #     @images << "すだち成長記録_180429_0050.jpg"
  #     @images << "すだち成長記録_180429_0051.jpg"
  #     @images << "すだち成長記録_180429_0052.jpg"
  #     @images << "すだち成長記録_180429_0053.jpg"
  #     @images << "すだち成長記録_180429_0054.jpg"
  #     @images << "すだち成長記録_180429_0055.jpg"
  #     @images << "すだち成長記録_180429_0056.jpg"
  #     @images << "すだち成長記録_180429_0057.jpg"
  #     @images << "すだち成長記録_180429_0058.jpg"
  #     @images << "すだち成長記録_180429_0059.jpg"
  #     @images << "すだち成長記録_180429_0060.jpg"
  #     @images << "すだち成長記録_180429_0061.jpg"
  #     @images << "すだち成長記録_180429_0062.jpg"
  #     @images << "すだち成長記録_180429_0063.jpg"
  #     @images << "すだち成長記録_180429_0065.jpg"
  #     @images << "すだち成長記録_180429_0066.jpg"
  #     @images << "すだち成長記録_180429_0067.jpg"
  #     @images << "すだち成長記録_180429_0068.jpg"
  #     @images << "すだち成長記録_180429_0069.jpg"
  #     @images << "すだち成長記録_180429_0070.jpg"
  #     @images << "すだち成長記録_180429_0071.jpg"
  #     @images << "すだち成長記録_180429_0073.jpg"
  #     @images << "すだち成長記録_180429_0074.jpg"
  #     @images << "すだち成長記録_180429_0075.jpg"
  #     @images << "すだち成長記録_180429_0076.jpg"
  #     @images << "すだち成長記録_180429_0078.jpg"
  #     @images << "すだち成長記録_180429_0079.jpg"
  #     @images << "すだち成長記録_180429_0080.jpg"
  #     @images << "すだち成長記録_180429_0081.jpg"
  #   end
  # end
end
