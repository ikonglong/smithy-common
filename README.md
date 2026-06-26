# smithy-common

可复用的公共 Smithy 模型（`common` 命名空间）：错误结构、分页、国际化与通用类型。
通过 [JitPack](https://jitpack.io) 以 Maven JAR 形式分发，供各 API 定义仓库依赖、复用同一套公共模型。

## 内容

`model/` 下的 `common` 命名空间：

| 文件 | 提供 |
| --- | --- |
| `error.smithy` | `Error`、`ErrorStatusCode`、`HTTP4xxResp`、`HTTP5xxResp`、`OperationErrors`（mixin） |
| `pagination.smithy` | `PagingParams` / `PageMetadata`（mixin）、`SortOrder` |
| `types.smithy` | `I18nText`、`Language`、`LanguageCode`、`JSONSchema`、`Any` |

## 在消费方使用

在消费方的 `smithy-build.json` 中加入依赖与 JitPack 仓库：

```jsonc
{
  "maven": {
    "dependencies": [
      "com.github.ikonglong:smithy-common:main-SNAPSHOT"
    ],
    "repositories": [
      { "url": "https://repo.maven.apache.org/maven2/" },
      { "url": "https://jitpack.io" }
    ]
  }
}
```

随后即可在模型里直接引用，例如：

```smithy
use common#OperationErrors
use common#PagingParams
use common#Error
```

> `smithytranslate-traits`（`error.smithy` 依赖它）已作为本包的 `api` 依赖，会通过 POM 传递给消费方，消费方无需单独声明。

## 版本

当前处于**正式版（1.0）之前**的预发布阶段，采用 `main-SNAPSHOT`：

- `com.github.ikonglong:smithy-common:main-SNAPSHOT` —— 始终跟随 `main` 最新提交（**可变**，JitPack 按需重建并有缓存 TTL）。适合内部联调迭代。
- 模型稳定、需要对外稳定承诺时，改为打 `0.x.y` tag（SemVer `0.x` 预发布线，允许破坏性变更），消费方 pin 具体版本；最终稳定升 `1.0.0` 作为首个正式版。

JitPack 坐标的版本段等于 git tag 字符串原样（tag 不带 `v` 前缀）。

## 构建

```bash
./gradlew build          # 产出 build/libs/smithy-common-*.jar，内含 META-INF/smithy/
./gradlew publishToMavenLocal
```

JitPack 在消费方首次拉取某版本时，于其 JDK 17 环境执行 `./gradlew build publishToMavenLocal` 现场构建并缓存，本仓库无需自行发布。

需要 JDK 17+。
