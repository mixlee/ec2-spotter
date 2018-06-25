# AWS Persistant Spot Intance
Forked from https://github.com/atramos/ec2-spotter

EC2 spot instances behave much like regular instances, but are cheaper. 
Normally, they can only be inited from an AMI image, not EBS volume, resetting any changes made along the way.
This script enables you to continue with your Spot instance where you left off.

Refer to this medium post for information on how to use this:
https://medium.com/slavv/learning-machine-learning-on-the-cheap-persistent-aws-spot-instances-668e7294b6d8


## 项目及改动简介:
* 项目是Fork的fast-ai相关代码分支， 旨在使用spot实例进行GPU实例的创建和销毁， 并且使用EBS硬盘持久化化训练代码;
* 改动主要为对aws中国区的配置适配和对cloud-init脚本对EBS存储持久化的修改，另外新增实例销毁脚本;
* 关于使用fast-ai脚本创建VPC及EBS配置的脚本这里不进行修改适配, 默认为你手工已创建相关配置;
* 注意, 实例创建、销毁及挂载硬盘都是使用Tag的方式进行识别的, 测试时避免与其他环境服务器Tag混淆;

## 使用方法
* 根据需要补全cn-spot.conf, 没有的资源提前配置好后填入配置文件;
* 创建 AWS_CONFIG_FILE 配置信息(参考AWS官方文档);
* 开启Spot实例: fast_ai/start_spot_cn.sh
* 销毁Spot实例: fast_ai/terminate_spot_cn.sh
