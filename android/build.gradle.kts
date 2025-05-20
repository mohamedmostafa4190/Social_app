allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
buildscript {
    repositories {
        google()
        jcenter()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.4.0") // نسخة حديثة ومستقرة
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.0.0") // نسخة Kotlin المطلوبة
        classpath("com.google.gms:google-services:4.4.0") // ✅ هذا الإصدار هو الموجود حاليًا في الـ classpath
    }
}


val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
