 -addr字符串
        ip：侦听请求的端口。当作为客户端代理运行时，我们将使用http监听，当作为服务器代理运行时，我们将使用https（必需）进行监听
IP：侦听请求的端口当作为客户端代理运行时，我们将使用HTTP监听，当作为服务器代理运行时，我们将使用HTTPS（必需）进行监听
  -borda-report-interval持续时间
        向borda报告错误的频率。设置为0以禁用报告。 （默认5m0s）
  -borda-sample-percentage float
        要报告给Borda的设备百分比（0.01 = 1％）（默认值为0.01）
  剔透代理的设置
        如果为true，Lantern将从系统中删除代理设置。

  -cloudconfig字符串
        用于配置更新的基于云的源的可选http（s）URL
  -cloudconfigca字符串
        可选的PEM编码证书，用于验证TLS连接以获取cloudconfig
  -configdir字符串
        存储配置的目录，包括flashlight.yaml（默认为当前目录）
存储配置的目录，包括flashlight.yaml（默认为当前目录）
   - 国家字符串
        用于报告统计数据的2位数国家/地区代码。默认为xx。 （默认“xx”）
  -cpuprofile字符串
        将cpu配置文件写入给定文件
  -force-auth-token字符串
        如果指定，则强制链接代理使用此身份验证令牌而不是配置的令牌
  -force-proxy-addr字符串
        如果指定，则强制链接代理使用此地址而不是已配置的地址
  -frontedconfig字符串
        用于配置更新的基于云的源的可选http（s）URL
  -headless
        如果是真的，灯笼将在没有ui的情况下运行
  -救命
        获取使用帮助
  -loggly-sample-percentage float
        报告Loggly的设备百分比（0.02 = 2％）（默认0.02）
  -memprofile字符串
        将堆配置文件写入给定文件
  -obfs4-distBias
        使用ScrambleSuit样式表生成启用obfs4
  -pprofaddr字符串
        要监听的pprof地址，如果为空则不激活pprof
  -proxyall
        设置为true以通过Lantern网络代理所有流量
  -readableconfig
        如果指定，则禁用配置yaml的模糊处理，以使其保持人类可读性
  -registerat字符串
        要注册的对等DNS注册表的基本URL（例如https://peerscanner.getiantem.org）
  -staging
        如果为true，则对我们的暂存基础架构运行Lantern
  -启动
        如果为true，Lantern会在系统启动时自动运行
  -stickyconfig
        设置为true以仅使用本地配置文件
  -test.bench字符串
        正则表达式选择要运行的基准
  -test.benchmem
        打印基准的内存分配
  -test.benchtime持续时间
        每个基准测试的近似运行时间（默认为1秒）
  -test.blockprofile字符串
        执行后，将goroutine阻塞配置文件写入命名文件
  -test.blockprofilerate int
        如果> = 0，则调用runtime.SetBlockProfileRate（）（默认值为1）
  -test.count n
        运行测试和基准n次（默认1）
  -test.coverprofile字符串
        执行后，将覆盖配置文件写入命名文件
  -test.cpu字符串
        以逗号分隔的每个测试使用的CPU数量列表
  -test.cpuprofile字符串
        在执行期间将cpu配置文件写入命名文件
  -test.memprofile字符串
        执行后将内存配置文件写入命名文件
  -test.memprofilerate int
        如果> = 0，则设置runtime.MemProfileRate
  -test.outputdir字符串
        编写配置文件的目录
  -test.parallel int
        最大测试并行度（默认为4）
  -test.run字符串
        正则表达式选择要运行的测试和示例
  -test.short
        运行较小的测试套件以节省时间
  -test.timeout持续时间
        如果为正，则为所有测试设置总时间限制
  -test.trace字符串
        执行后将执行跟踪写入命名文件
  -test.v
        详细：打印其他输出
  -uiaddr字符串
        如果指定，则表示host：port应启动UI HTTP服务器（默认为“127.0.0.1:16823”）
		
httptest.serve:
obfs4-distBias:false
registerat:
test.failfast:false
test.outputdir:
test.v:false
test.mutexprofile:
addr:
cpuprofile:
headless:false
readableconfig:false
test.benchmem:false
test.memprofile:
borda-report-interval:15m0s
configdir:
test.benchtime:1s
test.coverprofile:
test.cpu:
test.timeout:0s
country:xx
force-proxy-addr:
help:false
test.blockprofile:
test.cpuprofile:
staging:false
force-auth-token:
test.list:
test.run:
test.short:false
borda-sample-percentage:0.01
clear-proxy-settings:false
cloudconfig:
test.parallel:16
uiaddr:
cloudconfigca:
memprofile:
pprofaddr:
test.mutexprofilefraction:1
test.testlogfile:
test.trace:
test.count:1
test.memprofilerate:0
proxyall:false
socksaddr:
startup:false
stickyconfig:false
test.bench: