# React Native AES Meuvo

React Native AES Muevo is An extensive AES crypto modules for react-native. 
It uses native crypto modules instead of shims. 

Utalizing Javascript shims of certain cryptographic functions for React Native will lead to unexpected results. Production builds become unresponsive and slow, especially on older devices. A problem is that this performance issue only becomes noticible in production builds as debug builds of React Native rely on the v8 engine for debugging purposes.

React Native AES Meuvo utilizes native crypto modules under the hood and this has a beneficial impact on the performance of your production builds. The methods have been tested with blockchain implemementations. 

React Native AES  Muevo contains the following cryptographic functions:

-   `encrypt(text, key, iv)`
-   `decrypt(base64, key, iv)`
-   `pbkdf2(text, salt, cost, length)`
-   `hmac256(cipher, key)`
-   `hmac512(cipher, key)`
-   `sha1(text)`
-   `sha256(text)`
-   `sha512(text)`
-   `randomUuid()`
-   `randomKey(length)`

## Installation

```sh
npm install --save @muevo/react-native-aes-crypto
```

or

```sh
yarn add @muevo/react-native-aes-crypto
```

### Installation (iOS)

##### Using CocoaPods (React Native 0.60 and higher)

```sh
cd ios
pod install
```

##### Using React Native Link (React Native 0.59 and lower)

Run `react-native link react-native-aes-crypto` after which you should be able to use this library on iOS.

### Installation (Android)

##### React Native 0.60 and higher
- Linking is done automatically

##### Using React Native Link (React Native 0.59 and lower)
-   In `android/settings.gradle`

```gradle
...
include ':react-native-aes-crypto'
project(':react-native-aes-crypto').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-aes-crypto/android')
```

-   In `android/app/build.gradle`

```gradle
...
dependencies {
    ...
    compile project(':react-native-aes-crypto')
}
```

-   register module (in MainApplication.java)

```java
......
import com.tectiv3.aes.RCTAesPackage;

......

@Override
protected List<ReactPackage> getPackages() {
   ......
   new RCTAesPackage(),
   // or 
   // packages.add(new RCTAesPackage());
   ......
}
```

## Usage

### Examples
With every cryptographic module the format of the input is very important. If the input has a wrong format, it may lead to unexpected results

##### Pdfk2
The text and salt variables both are fromatted as utf-8 strings

```js
import { NativeModules } from 'react-native';
const Aes = NativeModules.Aes;

const salt = (password) => {
	return 'mnemonic' + (password) || ''); 
}

const mnemonic = 'mean later wish foil cable busy van idea mind drastic drill bike';

const mnemonicBuffer = Buffer.from(mnemonic, 'utf8');
const saltBuffer = Buffer.from(salt(password), 'utf8');

Aes.pbkdf2(
    mnemonicBuffer.toString('utf8'),
    saltBuffer.toString('utf8'),
    2048,
    512
)
    .then((seed) => {
        console.log(seed)
    })
    .catch((seedError) => {
        console.log(seedError)
    });
```

##### Hmac512
The cipher and key variables both need to be formatted as a hex string

```js
import { NativeModules } from 'react-native';
const Aes = NativeModules.Aes;

const seed = Buffer.from('seed', 'utf8').toString('hex');
const key = Buffer.from('Bitcoin seed', 'utf8').toString('hex');

Aes.hmac512(seed, key).then((hash)=>{
    console.log(hash)
}).catch((hasError) => {
    console.log(hashError)
});

```
##### Encrypt / decrypt

The text and key variables both are formatted as uff-8 strings. The cipher is a base64 encoded string

```js
import { NativeModules, Platform } from 'react-native'
var Aes = NativeModules.Aes

const generateKey = (password, salt, cost, length) => Aes.pbkdf2(password, salt, cost, length)

const encryptData = (text, key) => {
    return Aes.randomKey(16).then(iv => {
        return Aes.encrypt(text, key, iv).then(cipher => ({
            cipher,
            iv,
        }))
    })
}

const decryptData = (encryptedData, key) => Aes.decrypt(encryptedData.cipher, key, encryptedData.iv)

try {
    generateKey('Arnold', 'salt', 5000, 256).then(key => {
        console.log('Key:', key)
        encryptData('These violent delights have violent ends', key)
            .then(({ cipher, iv }) => {
                console.log('Encrypted:', cipher)

                decryptData({ cipher, iv }, key)
                    .then(text => {
                        console.log('Decrypted:', text)
                    })
                    .catch(error => {
                        console.log(error)
                    })

                Aes.hmac256(cipher, key).then(hash => {
                    console.log('HMAC', hash)
                })
            })
            .catch(error => {
                console.log(error)
            })
    })
} catch (e) {
    console.error(e)
}
```


