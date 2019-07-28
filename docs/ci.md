
CI(Continuous Integration)持续集成，CD(Continuous Delivery) 持续交付
### 为什么做CI
1、分支偏离主干

2、未知项目进度

3、发现bug较晚

4、定位问题复杂

### CI价值
1.二进制包准备降低风险：静态代码分析，尽早发现bug

2.自动化：自动化编译、自动化测试、自动部署、自动审查、自动反馈

3.随时发布

### 重点
为了提高代码质量已经每次发布到beta环境服务的稳定性，要提高自动化测试覆盖率（不仅限于接口自动化测试）

### CI系统流程
流程图如下：
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/1.png)

### CI详细流程图如下
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/2.png)

### 代码提交流程
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/3.png)

### 自测环境发布流程
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/4.png)

1、当git lab上有代码向dev_test分支发起merge请求，触发自测环境的jenkins sonar扫描；

2、sonar扫描--针对dev_test分支；

3、单元测试--针对dev_test分支；

4、构建自测环境，并运行自测环境--针对dev_test分支；

5、执行接口自动化测试；

6、接口自动化测试通过后，在自测环境中进行功能测试、新增接口测试，并将新增测试点新增到自动化测试案例库中。

###  Beta环境发布流程（分支：dev）
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/5.png)
1、当git lab上有代码向dev分支发起merge请求，触发jenkins sonar扫描；

2、sonar扫描--针对dev分支

3、单元测试--针对dev分支

4、构建自测环境，并运行自测环境--针对dev分支

5、执行接口自动化测试；

6、接口自动化测试通过后，将测试通过的dev分支发布并部署到beta环境。

### 流程触发机制
1、使用gitlab webhooks

![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/6.png)

2、URL处输入构建的url地址，需增加token信息；

http://jenkins.cn/view/decision/job/decision-sonar/build

3、Secret Token 输入jenkins中需由gitlab merge请求触发的工程中配置身份令牌
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/7.png)


### 触发机制配置merge请求时触发
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/8.png)
4、提交merge请求，触发流程

### 操作说明
1、新建jenkins项目
新建sonar扫描、单元测试、构建、自动化测试、beta环境构建五个项目。

2、配置meta data
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/9.png)

3、新建pipeline视图
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/10.png)

4、设置CI初始项目名称
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/11.png)

5、CI初始项目设置依赖关系.注意：依赖关系一定要顺序执行，避免形成环形依赖
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/12.png)

6、设置预警声音(可自定义声音，音频格式的文件为wav格式，并且将音频文件打包好给叶柄添加到jenkins服务器上即可)
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/13.png)

7、Sonar扫描项目配置
mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent
mvn sonar:sonar

8、单元测试项目配置
-Dmaven.test.skip=false

9、自动化项目配置
http://jenkins.puhuitech.cn/view/decision/job/puhui-decision-autotest/

10、发送测试报告

1）、安装jenkins插件，Editable Email Notification

2）、选择构建后操作，Editable Email Notification；

3）、Project Recipient List：输入收件人的邮箱地址，收件人之间使用逗号隔开；

4）、Default Subject：邮件主题

5）、Default Content：邮件内容自定义

![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/14.png)

预热内容--使用Groovy脚本新建pipeline流程

1、新建一个项目类型为Pipeline的jenkins工程
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/15.png)

2、配置groovy脚本
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/16.png)

3、pipeline 模板脚本生成
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/17.png)

4、pipeline进程查看
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/18.png)

jenkins 2.0建自动化构建之pipeline语法：
![image](https://github.com/ziyilongwang/k8s-salt/blob/master/docs/ciimage/19.png)










