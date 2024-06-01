resource "aws_sns_topic" "mc_server_alarm_sns_topic" {
  name = "minecraft-server-alarm-sns-sms-topic"
  delivery_policy = jsonencode({
    "http" : {
      "defaultHealthyRetryPolicy" : {
        "minDelayTarget" : 20,
        "maxDelayTarget" : 20,
        "numRetries" : 3,
        "numMaxDelayRetries" : 0,
        "numNoDelayRetries" : 0,
        "numMinDelayRetries" : 0,
        "backoffFunction" : "linear"
      },
      "disableSubscriptionOverrides" : false,
      "defaultThrottlePolicy" : {
        "maxReceivesPerSecond" : 1
      }
    }
  })
}

resource "aws_sns_topic_subscription" "mc_server_alarm_topic_subscription" {
  count     = length(local.sms_numbers)
  topic_arn = aws_sns_topic.mc_server_alarm_sns_topic.arn
  protocol  = "sms"
  endpoint  = "+${local.sms_numbers[count.index]}"
}

resource "aws_sns_topic" "mc_server_ok_sns_topic" {
  name = "minecraft-server-ok-sns-sms-topic"
  delivery_policy = jsonencode({
    "http" : {
      "defaultHealthyRetryPolicy" : {
        "minDelayTarget" : 20,
        "maxDelayTarget" : 20,
        "numRetries" : 3,
        "numMaxDelayRetries" : 0,
        "numNoDelayRetries" : 0,
        "numMinDelayRetries" : 0,
        "backoffFunction" : "linear"
      },
      "disableSubscriptionOverrides" : false,
      "defaultThrottlePolicy" : {
        "maxReceivesPerSecond" : 1
      }
    }
  })
}

resource "aws_sns_topic_subscription" "mc_server_ok_topic_subscription" {
  count     = length(local.sms_numbers)
  topic_arn = aws_sns_topic.mc_server_ok_sns_topic.arn
  protocol  = "sms"
  endpoint  = "+${local.sms_numbers[count.index]}"
}