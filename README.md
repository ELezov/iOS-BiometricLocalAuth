# iOS-BiometricLocalAuth

# Биометрическая аутентификация в iOS!


Биометрическая аутентификация — это процедура проверки подлинности заявленных пользователем данных, с помощью предоставления пользователем своего биометрического образа, а также процесс преобразования этого образа в соответствии с заранее определенным протоколом аутентификации.

![][LOGO]

##### Биометрическая аутентификация в iOS представлена (на момент написания) двумя видами:
* аутентификация по отпечатку пальца (**Touch ID**)
* аутентификация по форме лица (**Face ID**)

Впервые возможность использования технологии **Touch ID** появилась в iOS 8 и была встроена в iPhone 5s.
При касании аппарат сканирует отпечаток пальца и сравнивает его с эталонным, который был заранее занесен в систему. К слову, отпечатков в системе может быть несколько. 

Позже с появлением камеры TrueDepth и выходом iPhone X, Apple показала технологию под названием **Face ID**, которая пришла на смену **Touch ID**.
Принцип работы заключается в том, что для разблокировки телефона необходимо, чтобы инфракрасная камера произвела сканирование вашего лица. Тут так же происходит сравнение с некоторым эталоном, который заранее заносится в память телефона. В iOS 12 появилось возможность внесения двух образов в систему.

Хочется отметить, что **Face ID** считается более стабильным в работе и надежным, чем **Touch ID**, хотя сама [Apple](https://www.theguardian.com/technology/2017/sep/27/apple-face-id-iphone-x-under-13-twin-facial-recognition-system-more-secure-touch-id) не использовать Face ID, если у вас есть брат-близнец :busts_in_silhouette: , да и случаи сбоев в работе бывают, правда не такие частые как с Touch ID, но пораждающие различные мемы.

![](https://preview.redd.it/jix6gjnkollz.jpg?width=480&auto=webp&s=c293500efd1a8fc31fc42af37727956c12c1f447) ![](https://i.imgflip.com/1vu07e.jpg)

Данные технологии активно используются для авторизации покупок в iTunes Store, App Store, а также платежей через Apple Pay.

Закончим со справочной информацией и перейдем к коду.

Работа с **Touch ID**/**Face ID** осуществляется через [**LocalAuthentication.framework**](https://developer.apple.com/documentation/localauthentication). 

Замечательным для разработчиков является то, что используется одна реализация для работы с этими двумя технологиями.

### Простой пример

1. Для начала работы необходимо создать context проверки подлинности:

    ```let context = LAContext()```
    
2. Далее мы должны проверить, можем ли мы использовать биометрическую аутентификацию:

    ```context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError)```
    
3. Если использование биометрической аутентификации возможно, то пробуем авторизоваться: 

``` swift
    let reason = /* Здесь указывается причина для авторизации, которая будет отображена пользователю */
    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                       localizedReason: reason) { success, evaluateError in
    	/* handle error and do smth */
    }
```

Дальше давайте поговорим о трудностях, которые могут возникнуть при реализации данной функциональности в вашем приложении.
Следующий раздел статьи является наиболее важным.
    
### Обработка исключительных ситуаций

##### 1. Отслеживание изменения биометрических данных в системе
Данный случай рассматриват ту ситуацию, когда мы должны обрабатывать изменение биометрических данных в системе, таких как добавление и удаление их из системы.

Это недокументированное исключение, отслеживать событие необходимо вручную.

Такую ситуацию обычно обрабатывают так:
``` swift
// Проверяем, были ли изменены биометрические данные
func biometricDateIsValid() -> Bool {
    let context = LAContext()
    context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    var result: Bool = true
    // Получаем сохраненный биометрические данные
    let oldDomainState = UserDefaultsHelper.biometricDate
    // Получаем текущие биометрические данные
    guard let domainState = context.evaluatedPolicyDomainState
        else { return result }
    // Сохраняем новые текущие биометрические данные в UserDefaults
    UserDefaultsHelper.biometricDate = domainState
    result = (domainState == oldDomainState || oldDomainState == nil)
    return result
  }
```

После проверки на возможность использования биометрической аутентификации, мы получаем текущий [**PolicyDomainState**](https://developer.apple.com/documentation/localauthentication/lacontext/1514150-evaluatedpolicydomainstate) из context и сравниваем с тем,который был раньше. При каждой успешной аутентификации мы сохраняем текущий в UserDefaults. 

##### 2. Обработка системных ошибках

Для корректной работы нам необходимо знать и обрабатывать ошибки, которые могут возникнуть при работе.

![](https://memegenerator.net/img/instances/67111264.jpg)

Рассмотрим некоторые из системных ошибок:

- Биометрическая аутентификация недоступна на устройстве. ([biometryNotAvailable](https://developer.apple.com/documentation/localauthentication/laerror/2867590-biometrynotavailable))
- Аутентификация закончилась неуспешно, так как превышено количество попыток входа. ([biometryLockout](https://developer.apple.com/documentation/localauthentication/laerror/code/2867589-biometrylockout))
- Аутентификация закончилась неуспешно, так как на телефоне отсутствуют биометрические данные. ([biometryNotEnrolled](https://developer.apple.com/documentation/localauthentication/laerror/2867592-biometrynotenrolled))

Давайте рассмотрим часть кода.

``` swift
 var authError: NSError?
 if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
       context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                        localizedReason: reason) { success, evaluateError in
               reply (success, evaluateError)
       }
 } else {
       guard let error = authError else {
            return
       }
       reply (false, error)
 }

```
В случае провала аутентификации мы получим ошибку типа [LAError][ERROR].

Ошибку отсутствия возможности биометрической аутентификации можно не обрабатывать, так как она говорит нам лишь о том, что устройство пользователя не поддерживает ни Touch ID, ни Face ID. *Можно, конечно, сказать пользователю, что ему пора менять девайс.*

Другие же ошибки логичнее обработать. Давайте посмотрим один из вариантов.

``` swift
let errorCode = error._code
if #available(iOS 11.0, *) {
    if [LAError.biometryLockout.rawValue,
        LAError.biometryNotEnrolled.rawValue].contains(where: { $0 == errorCode }) {
        /* показываем alert с возможностью перехода в настройки телефона */
    } else {
        /* Уведомляем пользователя об ошибке и невозможности аутентификации*/
    }
} else {
    if [LAError.touchIDLockout.rawValue,
        LAError.touchIDNotEnrolled.rawValue].contains(where: { $0 == errorCode }) {
        /* показываем alert с возможностью перехода в настройки телефона */
    } else {
        /* Уведомляем пользователя об ошибке и невозможности аутентификации*/
    }
}
```

Если у пользователя превышено количество попыток ввода для аутентификации, то функция биометрической аутентификации автоматически блокируется. Ее можно разблокировать в настройках телефона через ввод пин-кода.

Если у пользователя не добавлены никакие биометрические данные в систему, то нужно предложить пользователю добавить их. Сделать это можно также в настройках телефона.

Из вышесказанного, можно сделать вывод, что логика обработки будет схожа - будем предлагать пользователю перейти в настройки.

Для перехода в настройки телефона из нашего приложения необходимо следующее:
``` swift
func showDeviceSettings() {
    guard let settingURL = URL(string: "App-Prefs:") else { return }    
    if UIApplication.shared.canOpenURL(settingURL){
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(settingURL)
        }
    }
}
```

Интересная особенность заключается в том, что в **iOS 10** вы могли перейти сразу на экран настройки **Touch ID** с помощью следующего URL:
``` swift 
URL(string: "App-Prefs:root=TOUCHID_PASSCODE") 
```
В **iOS 11** вы можете пройти только для главного экрана настроек.

##### 3. Экран авторизации и Face ID.

Часто в приложении на экране авторизации сразу включена биометрическая аутентификация. В случае c **Face ID**, в отличие от **Touch ID**, от пользователя не требуется почти никакой реакции (просто смотреть в телефон). Поэтому авторизация с **Face ID** происходит моментально. 

Но есть случаи, когда мы хотим разлогиниться и попадаем на экран авторизации,  на котором с помощью **Face ID** происходит чуть ли не мгновенная авторизация. В итоге получаем замкнутый цикл. ***Не приятно, не так ли?*** Поэтому этот случай требует `обязательного` отслеживания.

##### 4. Face ID и разрешение

Для работы **Face ID** необходимо добавить [**NSFaceIDUsageDescription**](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW75) в info.plist вашего приложения.
Данный ключ позволяет описать причину, по которой ваше приложение использует Face ID.

На реальном девайсе приложение будет крашиться, если вы будете стучаться к Face ID без этого ключа.

##### 5. Технология “быстрый вход”

Данная функциональность реализуется всего лишь с помощью добавления одного параметра при авторизации.
Реализуется благодаря параметру [**touchIDAuthenticationAllowableReuseDuration**](https://developer.apple.com/documentation/localauthentication/lacontext/1622329-touchidauthenticationallowablere)
``` swift
context.touchIDAuthenticationAllowableReuseDuration = 30
```
Этот параметр работает `только` с  **Touch ID** *(Не смотря на название переменной, была надежда, что это работает и с **Face ID**, поэтому решил проверить. В итоге - нет, не работает =) )*.
Данный параметр определяет продолжительность валидности последней сессий биометрической аутентификации. В данном случае имеется в виду время с последней разблокировки телефона *(не приложения)* с помощью биометрических данных.

Если вы уложились в это время, то аутентификация пройдет мгновенно.
По умолчанию данный параметр равен **0**.

`!` Есть кейс, когда пользователь, находясь в приложении, блокировал девайс, а потом после разблокировки телефона с помощью биометрических данных хотел разлогиниться. Тут можно получить похожую с Face ID ошибку. Этот случай тоже `необходимо` отслеживать, например отслеживать, откуда мы пришли на экран авторизации, и если мы пришли сюда после разлогина, то убирать использование параметра.

### Итоги

Биометрическая аутентификация на сегодняшний день популярна и имеет довольно простую реализацию для программиста, но необходимо учитывать различные ситуации. Защищайте данные своих пользователей правильно и делайте так, чтобы вашим приложением было приятно и удобно пользоваться =) .

##### Проект полностью вы можете посмотреть [тут][PROJECT]

[**Eugene Lezov, iOS Developer**][PROFILE_GITHUB]

Если вам понравилась статья, то хлопайте в ладоши.

![](http://jobandrest.com/images/hash/ed/04/8e/c08ab1bf5b1c4355b14dcb635f.jpg)

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [LOGO]: <https://www.intego.com/mac-security-blog/wp-content/uploads/2017/10/Touch-ID-vs-Face-ID.png>
   [SOFA]: <https://stackoverflow.com/questions/25669172/ios8-touchid-detection-if-fingerprint-was-added>
   [ERROR]: <https://developer.apple.com/documentation/localauthentication/laerror>
   [PROFILE_GITHUB]: <https://github.com/ELezov>
   [PROJECT]: <https://github.com/ELezov/iOS-BiometricLocalAuth/tree/develop>
