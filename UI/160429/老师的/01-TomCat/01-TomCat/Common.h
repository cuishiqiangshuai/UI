//
//  Common.h
//  01-TomCat
//
//  Created by qingyun on 16/4/29.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#ifndef Common_h
#define Common_h
//用上面的宏定义，传入参数图片的名称，可以获得资源文件的路径。
#define ResourcePath(imageName) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName]

#define ResourcePath2(imgName,type) [[NSBundle mainBundle] pathForResource:imgName ofType:type]

//用上面的函数宏，传入参数图片的路径，可以获得图片对象。
#define ImageWithPath(path) [[UIImage alloc] initWithContentsOfFile:path]

#define ImageWithPath2(path) [UIImage imageWithContentsOfFile:path]

#endif /* Common_h */
