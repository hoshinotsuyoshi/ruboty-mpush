module Ruboty
  module Handlers
    class Mpush < Base
      NAMESPACE = "mpush"

      on /(?<body>.+)/, name: 'mpop', description: 'message pop'
      on /mpush (?<body>.+)/, name: 'mpush', description: 'message push'

      def mpush(message)
        create(message)
        message.reply 'ok'
      end

      def mpop(message)
        return if message[:body].start_with? 'mpush'
        rep = mstack.pop
        message.reply rep if rep
      end

      def mstack
        robot.brain.data[NAMESPACE] ||= []
      end

      def create(message)
        mstack.push message[:body]
      end
    end
  end
end
