resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "Minecraft-Server-Health-Dashboard"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 12,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/EC2",
                        "CPUUtilization",
                        "InstanceId",
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}"
                    ]
                ],
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Server CPU Usage (1 Min Aggregation)"
            }
        },
        {
            "type": "metric",
            "x": 13,
            "y": 0,
            "width": 12,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/EC2",
                        "CPUUtilization",
                        "InstanceId",
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}"
                    ]
                ],
                "period": 300,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Server CPU Usage (5 Min Aggregation)"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 7,
            "width": 4,
            "height": 4,
            "properties": {
                "metrics": [
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "disk_total", 
                        "path", 
                        "/", 
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}", 
                        "ImageId", 
                        "${data.terraform_remote_state.ec2.outputs.server_ami_id}", 
                        "customized_dimension_key_3", 
                        "customized_dimension_value_3", 
                        "customized_dimension_key_4", 
                        "customized_dimension_value_4", 
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}", 
                        "device", 
                        "nvme0n1p1", 
                        "fstype", 
                        "xfs"
                    ]
                ],
                "view": "singleValue",
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Total Disk (GB)"
            }
        },
        {
            "type": "metric",
            "x": 4,
            "y": 7,
            "width": 4,
            "height": 4,
            "properties": {
                "metrics": [
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "disk_free", 
                        "path", 
                        "/", 
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}", 
                        "ImageId", 
                        "${data.terraform_remote_state.ec2.outputs.server_ami_id}", 
                        "customized_dimension_key_3", 
                        "customized_dimension_value_3", 
                        "customized_dimension_key_4", 
                        "customized_dimension_value_4", 
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}", 
                        "device", 
                        "nvme0n1p1", 
                        "fstype", 
                        "xfs"
                    ]
                ],
                "view": "singleValue",
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Free Disk (GB)"
            }
        },
        {
            "type": "metric",
            "x": 8,
            "y": 7,
            "width": 4,
            "height": 4,
            "properties": {
                "metrics": [
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "disk_used", 
                        "path", 
                        "/", 
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}", 
                        "ImageId", 
                        "${data.terraform_remote_state.ec2.outputs.server_ami_id}", 
                        "customized_dimension_key_3", 
                        "customized_dimension_value_3", 
                        "customized_dimension_key_4", 
                        "customized_dimension_value_4", 
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}", 
                        "device", 
                        "nvme0n1p1", 
                        "fstype", 
                        "xfs"
                    ]
                ],
                "view": "singleValue",
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Used Disk (GB)"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 7,
            "width": 4,
            "height": 4,
            "properties": {
                "metrics": [
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "mem_total",
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}",
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}"
                    ]
                ],
                "view": "singleValue",
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Total System Memory (GB)"
            }
        },
        {
            "type": "metric",
            "x": 16,
            "y": 7,
            "width": 4,
            "height": 4,
            "properties": {
                "metrics": [
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "mem_free",
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}",
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}"
                    ]
                ],
                "view": "singleValue",
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Free System Memory (GB)"
            }
        },
        {
            "type": "metric",
            "x": 20,
            "y": 7,
            "width": 4,
            "height": 4,
            "properties": {
                "metrics": [
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "mem_used",
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}",
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}"
                    ]
                ],
                "view": "singleValue",
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Used System Memory (GB)"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 11,
            "width": 6,
            "height": 9,
            "properties": {
                "metrics": [
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "disk_free", 
                        "path", 
                        "/", 
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}", 
                        "ImageId", 
                        "${data.terraform_remote_state.ec2.outputs.server_ami_id}", 
                        "customized_dimension_key_3", 
                        "customized_dimension_value_3", 
                        "customized_dimension_key_4", 
                        "customized_dimension_value_4", 
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}", 
                        "device", 
                        "nvme0n1p1", 
                        "fstype", 
                        "xfs"
                    ],
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "disk_used", 
                        "path", 
                        "/", 
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}", 
                        "ImageId", 
                        "${data.terraform_remote_state.ec2.outputs.server_ami_id}", 
                        "customized_dimension_key_3", 
                        "customized_dimension_value_3", 
                        "customized_dimension_key_4", 
                        "customized_dimension_value_4", 
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}", 
                        "device", 
                        "nvme0n1p1", 
                        "fstype", 
                        "xfs"
                    ]
                ],
                "view": "pie",
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Disk Usage Chart (%)"
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 11,
            "width": 6,
            "height": 9,
            "properties": {
                "metrics": [
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "disk_used_percent",
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}",
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}"
                    ]
                ],
                "view": "singleValue",
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Used Disk (%)"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 11,
            "width": 6,
            "height": 9,
            "properties": {
                "metrics": [
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "mem_free",
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}",
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}"
                    ],
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "mem_used",
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}",
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}"
                    ],
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "mem_cached",
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}",
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}"
                    ]
                ],
                "view": "pie",
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "System Memory Chart (%)"
            }
        },
        {
            "type": "metric",
            "x": 18,
            "y": 11,
            "width": 6,
            "height": 4,
            "properties": {
                "metrics": [
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "mem_used_percent",
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}",
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}"
                    ]
                ],
                "view": "singleValue",
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Used System Memory (%)"
            }
        },
        {
            "type": "metric",
            "x": 18,
            "y": 11,
            "width": 6,
            "height": 5,
            "properties": {
                "metrics": [
                    [ 
                        "MinecraftServerCustomMetrics", 
                        "mem_available_percent",
                        "InstanceId", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_id}",
                        "InstanceType", 
                        "${data.terraform_remote_state.ec2.outputs.server_instance_size}"
                    ]
                ],
                "view": "singleValue",
                "period": 60,
                "stat": "Average",
                "region": "us-east-1",
                "title": "Available System Memory (%)"
            }
        },
        {
            "type": "log",
            "x": 0,
            "y": 16,
            "width": 24,
            "height": 10,
            "properties": {
                "query": "SOURCE 'minecraft-server-logs' | fields @timestamp, @message\n| sort @timestamp desc\n| parse @message /\\[(?<UTCtime>\\S+)\\]\\s+(?<logType>\\[\\w+\\s+.*\\]\\:|\\[\\w+.*\\]\\:)\\s+(?<logMessage>(?<=]:\\s).*)/\n| display UTCtime, logType, logMessage",
                "view": "table",
                "region": "us-east-1",
                "title": "Parsed Server Logs"
            }
        }
    ]
}
EOF
}