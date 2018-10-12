module Line
  class MessageBuilder
    attr_accessor :conversation

    def initialize
       @conversation = {
         welcome: {
           reply: [
             'We\'re so happy you\'re here.',
             'Welcome to RedPlanet and nice to have you here.',
             'You love it. We know.'
           ]
         },
         bye: {
           reply: [
             'We all want to say goodbye and good luck.',
             'Goodbye! :)',
             'Hope you had such a great time here.'
           ]
         },
         hi: {
           reply: [
             'Hello!, what can I do for you?',
             'Hi! :)',
             'Hey, how\'s it going?'
           ]
         },
         travel: {
           reply: [
             'So exciting!!! Where would you like to go?',
             'Where would you like to go?',
             'What\'s your favorite place go?',
             'Just tell me :)'
           ],
           command: [
             '---- select below ----'
           ],
           end_point: [
             '/hotel_location'
           ]
         },
         go: {
           reply: [
             'Look!! That\'s such a nice place!!!',
             'Come on!! Let\'s make it happen today :)',
             'This is the best place *EVER* :)'
           ],
           end_point: %w[/hotel_location /hotel/location]
         }
       }.freeze
    end

    def built_text(response_module:, response_type:)
      {
        type: 'text',
        text: conversation[response_module.to_sym][response_type.to_sym].sample
      }
    end

    def built_sticker
      {
        type: 'sticker',
        packageId: '3',
        stickerId: Random.new.rand(210..235).to_s
      }
    end

    def built_carousel(items)
      {
        type: 'template',
        altText: 'This is a image carousel template',
        template: {
          type: 'image_carousel',
          columns: items.each.map do |item|
            {
              imageUrl: item['image_path'],
              action: {
                type: 'message',
                label: item['display_name'],
                text: "I want to go to #{item['name']}"
              }
            }
          end
        }
      }
    end
  end
end