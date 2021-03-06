# flutter_particle_bg

[![pub package](https://img.shields.io/pub/v/flutter_particle_bg.svg)](https://pub.dartlang.org/packages/flutter_particle_bg)


The page implements the particle background effect(页面实现粒子背景效果)

![Demo](gif/view.gif)

## Usage

```
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: MooooooBackground(
          child: ListView(
            children: [
              Text('列表元素'),
              Container(
                height: 500,
                color: Colors.red[200].withOpacity(0.6),
                margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
                alignment: Alignment.center,
                child: Text('这是列表元素'),
              )
            ],
          ),
        ));
  }
```
### 相关参数

```
  double pointsize; // 点大小
  Color pointcolor; // 点颜色
  double linewidth; // 线宽度
  Color linecolor; // 线颜色
  double pointnumber; // 圆点数量
  double distancefar; //划线距离
  Color backgroundcolor; // 粒子位置背景
  double pointspeed; // 粒子运行速度
  AssetImage bgimg; // 背景
```



