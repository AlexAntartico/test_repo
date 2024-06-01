resource "aws_cloudwatch_metric_alarm" "Low_Disk_Storage" {
  alarm_name          = "MC_Server_Low_Disk_Storage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 5
  metric_name         = "disk_used_percent"
  namespace           = "MinecraftServerCustomMetrics"
  period              = 60
  statistic           = "Average"
  threshold           = 85
  alarm_description   = "This metric monitors the Minecraft Server's Disk Utilization"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.mc_server_alarm_sns_topic.arn]
  ok_actions          = [aws_sns_topic.mc_server_ok_sns_topic.arn]

  dimensions = {
    InstanceId   = "${data.terraform_remote_state.ec2.outputs.server_instance_id}"
    InstanceType = "${data.terraform_remote_state.ec2.outputs.server_instance_size}"
  }
}

resource "aws_cloudwatch_metric_alarm" "High_Memory_Usage" {
  alarm_name          = "MC_Server_High_Memory_Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 5
  metric_name         = "mem_used_percent"
  namespace           = "MinecraftServerCustomMetrics"
  period              = 60
  statistic           = "Average"
  threshold           = 85
  alarm_description   = "This metric monitors the Minecraft Server's Memory Utilization"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.mc_server_alarm_sns_topic.arn]
  ok_actions          = [aws_sns_topic.mc_server_ok_sns_topic.arn]

  dimensions = {
    InstanceId   = "${data.terraform_remote_state.ec2.outputs.server_instance_id}"
    InstanceType = "${data.terraform_remote_state.ec2.outputs.server_instance_size}"
  }
}

resource "aws_cloudwatch_metric_alarm" "High_CPU_Usage" {
  alarm_name          = "MC_Server_High_CPU_Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 85
  alarm_description   = "This metric monitors the Minecraft Server's CPU Utilization"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.mc_server_alarm_sns_topic.arn]
  ok_actions          = [aws_sns_topic.mc_server_ok_sns_topic.arn]

  dimensions = {
    InstanceId = "${data.terraform_remote_state.ec2.outputs.server_instance_id}"
  }
}