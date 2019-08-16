set JAVA_HOME=E:\test\config\graalvm-ee-19.1.1
set JDK_HOME=E:\test\config\graalvm-ee-19.1.1
set JRE_HOME=E:\test\config\graalvm-ee-19.1.1

set SVMBUILD=E:\test\config\graalvm-ee-19.1.1
set SVMLIB=%SVMBUILD%\lib

echo JAVA_HOME=%JAVA_HOME%
echo SVMBUILD=%SVMBUILD%

set PWD=E:\test\config\client

set PATH=%JAVA_HOME%\bin;%PATH%

%SVMBUILD%\bin\native-image ^
--shared ^
--no-fallback ^
--report-unsupported-elements-at-runtime ^
--allow-incomplete-classpath ^
-H:+JNI ^
-H:ReflectionConfigurationFiles=reflectionconfig-win.json ^
-H:JNIConfigurationFiles=jniconfig-win.json ^
-H:+ReportExceptionStackTraces ^
-Dprism.verbose=true ^
-cp E:\test\config\graalvm-ee-19.1.1\jre\lib\ext\jfxrt.jar;%SVMBUILD%\include\win32;%SVMBUILD%\bin ^
-jar target\client-1.0.0-SNAPSHOT.jar ^
-H:IncludeResourceBundles=com.sun.javafx.tk.quantum.QuantumMessagesBundle ^
-H:IncludeResourceBundles=com/sun/javafx/scene/control/skin/resources/controls ^
-H:IncludeResources=.*/.*frag$ ^
-H:IncludeResources=.*/.*fxml$ ^
-H:IncludeResources=.*/.*css$ ^
-H:IncludeResources=.*/.*gls$ ^
-H:IncludeResources=.*/.*ttf$ ^
-H:IncludeResources=.*/.*png$ ^
-H:IncludeResources=.*png$ ^
-H:IncludeResources=.*css$ ^
-H:IncludeResources=.*fxml$ ^
-H:EnableURLProtocols=http ^
--initialize-at-build-time=com.sun.javafx.PlatformUtil,^
com.sun.javafx.application.PlatformImpl ^
--delay-class-initialization-to-runtime=^
com.sun.glass,^
com.sun.javafx.UnmodifiableArrayList,^
com.sun.javafx.animation.TickCalculation,^
com.sun.javafx.application.HostServicesDelegate,^
com.sun.javafx.application.LauncherImpl,^
com.sun.javafx.application.ParametersImpl,^
com.sun.javafx.application.PlatformImpl$FinishListener,^
com.sun.javafx.beans.event.AbstractNotifyListener,^
com.sun.javafx.binding,^
com.sun.javafx.charts,^
com.sun.javafx.collections,^
com.sun.javafx.css,^
com.sun.javafx.cursor,^
com.sun.javafx.embed,^
com.sun.javafx.event,^
com.sun.javafx.font,^
com.sun.javafx.fxml,^
com.sun.javafx.geom,^
com.sun.javafx.iio,^
com.sun.javafx.image,^
com.sun.javafx.jmx,^
com.sun.javafx.logging,^
com.sun.javafx.media,^
com.sun.javafx.menu,^
com.sun.javafx.perf,^
com.sun.javafx.property,^
com.sun.javafx.robot,^
com.sun.javafx.runtime,^
com.sun.javafx.scene,^
com.sun.javafx.sg.prism,^
com.sun.javafx.stage,^
com.sun.javafx.text,^
com.sun.javafx.tk,^
com.sun.javafx.util,^
com.sun.javafx.webkit,^
com.sun.prism,^
com.sun.openpisces,^
com.sun.pisces,^
com.sun.scenario,^
javafx.animation,^
javafx.application.Application,^
javafx.scene,^
javafx.stage.Screen,^
javafx.stage.Window
