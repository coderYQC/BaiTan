//
//  MainProvider.swift
//  LynxIOS
//
//  Created by 叶波 on 2018/4/17.
//  Copyright © 2018年 叶波. All rights reserved.
//

//首页TabBar主视图

import ESTabBarController_swift
import SVProgressHUD
enum MainProvider{
    
    static func customAnimateRemindStyle(implies: Bool,isTapAdv:Bool = false) -> ESTabBarController {
       
        let tabBarController = ESTabBarController()
        let tabBar = tabBarController.tabBar as? ESTabBar
        tabBar?.itemCustomPositioning = .automatic
        tabBar?.isTranslucent = false
        
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            let vc = UtilTool.topViewController()
            switch index {
            case 0:
                if vc .isKind(of: HomeViewController.self){
                    NotificationCenter.default.post(name: Notification.Name.init(kHomeScrollToTop), object: nil)
                }
                return false
            case 1:
                if vc .isKind(of: MessageViewController.self){
                    NotificationCenter.default.post(name: Notification.Name.init("scrollToTop1"), object: nil)
                }
//                NotificationCenter.default.post(name: Notification.Name.init(kLoadCategoryData), object: nil)
                return false
//            case 2:
//                if Constants.isLogin == true {
//                    return false
//                } else {
//
//                    vc.navigationController?.pushViewController(UtilTool.getVcBySbAndVcName(sb: "login", vc: "login"), animated: true)
//                    return true
//                }
            case 2:
                
//                    if vc .isKind(of: OrderController.self){
//                        NotificationCenter.default.post(name: Notification.Name.init("scrollToTop3"), object: nil)
//                    }
                return false
            case 3:
                
                return false
            default:
                return false
            }
        }
        
        let v1 = HomeViewController()
        let v2 = MessageViewController()
        let v3 = ShoppingCartViewController()
        let v4 = MineViewController()
        
        v1.tabBarItem = ESTabBarItem(IrregularityBasicContentView(), title: "首页", image: UIImage(named: "tabbar_home_nor"), selectedImage: UIImage(named: "tabbar_home_sel"))
        v2.tabBarItem = ESTabBarItem(IrregularityBasicContentView(), title: "消息", image: UIImage(named: "tabbar_category_nor"), selectedImage: UIImage(named: "tabbar_category_sel"))
        v3.tabBarItem = ESTabBarItem(IrregularityBasicContentView(), title: "购物车", image: UIImage(named: "tabbar_category_nor"), selectedImage: UIImage(named: "tabbar_category_sel"))
        v4.tabBarItem = ESTabBarItem(IrregularityBasicContentView(), title: "我的", image: UIImage(named: "tabbar_profile_nor"), selectedImage: UIImage(named: "tabbar_profile_sel"))
        
        tabBarController.viewControllers = [MainNavigationController(rootViewController: v1),
                                            MainNavigationController(rootViewController: v2),
                                            MainNavigationController(rootViewController: v3),
                                            MainNavigationController(rootViewController: v4)]
        
        Constants.mineVcTabbarIndex = tabBarController.viewControllers!.count - 1
        
        tabBarController.title = "摆摊儿"
        tabBarController.tabBar.barTintColor = .white
        return tabBarController
    }
}
