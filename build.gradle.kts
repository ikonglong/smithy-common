plugins {
    `java-library`
    // smithy-jar applies smithy-base, builds the models under model/ and injects
    // them into the JAR under META-INF/smithy/ so the artifact is consumable as a
    // Smithy Maven dependency.
    id("software.amazon.smithy.gradle.smithy-jar") version "1.4.0"
    `maven-publish`
}

// group MUST match the JitPack coordinate prefix: com.github.<github-user>.
// Consumers reference this artifact as `com.github.ikonglong:smithy-common:<tag>`.
group = "com.github.ikonglong"

// JitPack maps the requested version (a git tag or `main-SNAPSHOT`) onto the built
// artifact, so this value is only a local default and does not need to be bumped
// per release while we publish via `main-SNAPSHOT`.
version = "0.1.0"

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

repositories {
    mavenCentral()
}

dependencies {
    // Pin the Smithy CLI that builds/validates the models, matching the consumers'
    // CI (smithy 1.61.0).
    smithyCli("software.amazon.smithy:smithy-cli:1.61.0")

    // error.smithy uses `smithytranslate#contentType`. Declared as `api` so the
    // trait is on the model build classpath here AND propagated to consumers via
    // the published POM — Smithy resolves transitive Maven dependencies, so a
    // consumer only needs to depend on smithy-common.
    api("com.disneystreaming.smithy:smithytranslate-traits:0.5.11")
}

publishing {
    publications {
        create<MavenPublication>("maven") {
            from(components["java"])
        }
    }
}
