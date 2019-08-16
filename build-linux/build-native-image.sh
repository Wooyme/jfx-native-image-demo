export JAVA_HOME='/usr/local/graalvm/19.1.1'
export JDK_HOME='/usr/local/graalvm/19.1.1'
export JRE_HOME='/usr/local/graalvm/19.1.1'
JFX_LIB=$JAVA_HOME/jre/lib

SVMBUILD=/usr/local/graalvm/19.1.1
SVMLIB=$SVMBUILD/lib

echo "JAVA_HOME="$JAVA_HOME
echo "JFX_LIB="$JFX_LIB
echo "SVMBUILD="$SVMBUILD
OLD_JAVA_HOME=$JAVA_HOME
echo 'Switching java home to:'$JAVA_HOME

PWD=$(pwd)
CLASSPATH="classes:$JFX_LIB/ext/jfxrt.jar:$SVMBUILD/include/linux:$SVMBUILD/bin"

export PATH=$JAVA_HOME/bin:$JFX_LIB:$PATH

set -x
$SVMBUILD/bin/native-image --server-shutdown-all

echo 'JAVA_HOME='$JAVA_HOME


$SVMBUILD/bin/native-image \
--no-fallback \
--report-unsupported-elements-at-runtime \
--enable-all-security-services \
--allow-incomplete-classpath \
-H:+JNI \
-H:ReflectionConfigurationFiles=reflectionconfig-linux.json \
-H:JNIConfigurationFiles=jniconfig-linux.json \
-H:+ReportExceptionStackTraces \
-Dprism.verbose=true \
-cp $CLASSPATH \
-jar target/client-1.0.0-SNAPSHOT.jar \
-H:Name=Client \
-H:IncludeResourceBundles=com.sun.javafx.tk.quantum.QuantumMessagesBundle \
-H:IncludeResourceBundles=com/sun/javafx/scene/control/skin/resources/controls \
-H:IncludeResources=.*/.*frag$ \
-H:IncludeResources=.*/.*fxml$ \
-H:IncludeResources=.*/.*css$ \
-H:IncludeResources=.*/.*gls$ \
-H:IncludeResources=.*/.*ttf$ \
-H:IncludeResources=.*/.*png$ \
-H:IncludeResources=.*png$ \
-H:IncludeResources=.*css$ \
-H:IncludeResources=.*fxml$ \
-H:EnableURLProtocols=http \
--enable-url-protocols=resource \
--initialize-at-build-time=com.sun.javafx.PlatformUtil,\
com.sun.javafx.application.PlatformImpl \
--delay-class-initialization-to-runtime=\
com.sun.glass,\
com.sun.javafx.UnmodifiableArrayList,\
com.sun.javafx.animation.TickCalculation,\
com.sun.javafx.application.HostServicesDelegate,\
com.sun.javafx.application.LauncherImpl,\
com.sun.javafx.application.ParametersImpl,\
com.sun.javafx.application.PlatformImpl\$FinishListener,\
com.sun.javafx.beans.event.AbstractNotifyListener,\
com.sun.javafx.binding,\
com.sun.javafx.charts,\
com.sun.javafx.collections,\
com.sun.javafx.css,\
com.sun.javafx.cursor,\
com.sun.javafx.embed,\
com.sun.javafx.event,\
com.sun.javafx.font,\
com.sun.javafx.fxml,\
com.sun.javafx.geom,\
com.sun.javafx.iio,\
com.sun.javafx.image,\
com.sun.javafx.jmx,\
com.sun.javafx.logging,\
com.sun.javafx.media,\
com.sun.javafx.menu,\
com.sun.javafx.perf,\
com.sun.javafx.property,\
com.sun.javafx.robot,\
com.sun.javafx.runtime,\
com.sun.javafx.scene,\
com.sun.javafx.sg.prism,\
com.sun.javafx.stage,\
com.sun.javafx.text,\
com.sun.javafx.tk,\
com.sun.javafx.util,\
com.sun.javafx.webkit,\
com.sun.prism,\
com.sun.scenario,\
javafx.animation,\
javafx.application.Application,\
javafx.scene,\
javafx.stage.Screen,\
javafx.stage.Window

JAVA_HOME=$OLD_JAVA_HOME
$SVMBUILD/bin/native-image --server-shutdown-all
