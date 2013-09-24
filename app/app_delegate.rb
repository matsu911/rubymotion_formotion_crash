# avoid crash
# class Formotion::Form
#   def row(key)
#     ret = nil
#     each_row do |row|
#       if row.key == key
#         ret = row
#         break
#       end
#     end
#     ret
#   end
# end

class ConfigViewController < Formotion::FormController
  def init
    if super()
      self.tabBarItem.title = "settings"
    end

    self.initWithStyle(UITableViewStyleGrouped)

    self
  end

  def viewDidLoad
    form = {
      title: 'settings',
      sections:
      [{
         rows:
         [{
            title: 'profile',
            key: :profile,
            type: :subform,
            subform: {
              title: 'profile',
              sections:
              [{
                 rows:
                 [{
                    title: "update profile",
                    type: :submit,
                  }]
               }]
            }
          }]
       }]
    }

    @form = Formotion::Form.new(form)

    @form.row(:profile).subform.to_form.on_submit do |form|
    end

    initWithForm(@form)

    super
  end
end

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    @window.rootViewController = UITabBarController.alloc.init.tap do |x|
      x.setViewControllers([UIViewController.alloc.init,
                            ConfigViewController.alloc.init].map{ |x|
                             c = UINavigationController.alloc.initWithRootViewController x
                             c.delegate = x
                             c.navigationBar.translucent = false
                             c
                           },
                           animated:false)
    end

    true
  end
end
