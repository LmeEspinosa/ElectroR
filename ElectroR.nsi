;--------------------------------
;Incluimos el Modern UI

  !include "MUI2.nsh"

;--------------------------------
;Propiedades de la interfaz

  !define MUI_ABORTWARNING
  !define NOMBREAPP "ElectroR"

;--------------------------------
#General

;Nombre de la aplicación y del ejecutable
   Name "${NOMBREAPP}"
   Icon "ElectroR.ico"
   OutFile "ElectroR.exe"

;Directorio de instalación
   DirText "Elija un directorio donde instalar la aplicación:"
   InstallDir "$PROGRAMFILES\LabSW\20161\serviceG4${NOMBREAPP}"

;Obtenemos el directorio del registro (si esta disponible)
   InstallDirRegKey HKCU "LabSW\20161" ""
  
;Indicamos que cuando la instalación se complete no se cierre el instalador automáticamente
   AutoCloseWindow false

;Si se encuentran archivos existentes se sobreescriben
   SetOverwrite on
   SetDatablockOptimize on

;--------------------------------
#Paginas
;páginas referentes al instalador
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES

;páginas referentes al desinstalador
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
#Lenguajes
;Definimos el idioma del instalador
  !insertmacro MUI_LANGUAGE "Spanish"

;--------------------------------

#Secciones

Section "Electro R" ElectroR

  SetOutPath "$INSTDIR"
;Hacemos que esta seccion tenga que instalarse obligatoriamente
  SectionIn RO 

;Incluimos todos los archivos que componen nuestra aplicación

  ;Archivos a instalar (solo archivos, los ejecutables van en la sección "prerequisitos"
  File ElectroR.jar
  File "ElectroR.ico"

;Menu inicio
  SetShellVarContext all
  createDirectory "$SMPROGRAMS\LabSW\20161\serviceG4\${NOMBREAPP}"
  createShortCut "$SMPROGRAMS\LabSW\20161\serviceG4\${NOMBREAPP}\${NOMBREAPP}.lnk" "$INSTDIR\ElectroR.jar" "" "$INSTDIR\ElectroR.ico"
  createShortCut "$SMPROGRAMS\LabSW\20161\serviceG4\${NOMBREAPP}\Desinstalar.lnk" "$INSTDIR\Uninstall.exe" "" ""
    
;Acceso directo en el escritorio
  CreateShortCut "$DESKTOP\${NOMBREAPP}.lnk" "$INSTDIR\${NOMBREAPP}.jar" "" "$INSTDIR\ElectroR.ico"
  
;Hacemos que la instalación se realice para todos los usuarios del sistema
  SetShellVarContext all

;Guardamos un registro de la carpeta instalada
  WriteRegStr HKCU "$C:\PROGRAMFILES\LabSW\20161\serviceG4${NOMBREAPP}" "" $INSTDIR
  
;Creamos un desintalador
  WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd


#Seccion desinstalador

Section "Uninstall"

SetShellVarContext all

;Borramos el ejecutable del menú inicio
  delete "$SMPROGRAMS\LabSW\20161\serviceG4\${NOMBREAPP}\${NOMBREAPP}.lnk"
  delete "$SMPROGRAMS\LabSW\20161\serviceG4\${NOMBREAPP}\${NOMBREAPP}\Desinstalar.lnk"

;Borramos el acceso directo del escritorio
  delete "$DESKTOP\${NOMBREAPP}.lnk"

;Intentamos borrar el menú inicio (Solo se puede hacer si la carpeta está vacío)
  rmDir "$SMPROGRAMS\LabSW\20161\serviceG4\${NOMBREAPP}"
 
;Archivos a desinstalar
    delete $INSTDIR\ElectroR.jar
    delete $INSTDIR\ElectroR.ico
 
;Borramos el desinstalador
  delete $INSTDIR\Uninstall.exe
 
;Intentamos borrar la carpeta de instalación (Solo se puede si está vacía)
  rmDir $INSTDIR

  DeleteRegKey /ifempty HKCU "Electro R"

SectionEnd


#Seccion Prerequisitos, ejecucion de otros instaladores 

Section "Prerequisitos" prerequisitos

SectionIn RO

DetailPrint "Creacion del directorio"
    File "crear_carpeta.bat"
	
DetailPrint "Comenzando la configuracion de Mysql Server"
   ExecWait "$INSTDIR\crear_carpeta.bat"

DetailPrint "Comenzando a configurar la base"
    File "bd.bat"
    File "ElectroR.sql"

DetailPrint "Comenzando la configuracion de Mysql Server"
    ExecWait "$\"C:\Program Files\MySQL\MySQL Server 5.5\bin\MySQLInstanceConfig$\" -i -q ServiceName=MYSQL RootPassword=root ServerType=DEVELOPMENT DatabaseType=MYISAM PORT=3306 RootCurrentPassword=root"
    ExecWait "$INSTDIR\bd.bat"

SectionEnd  

;--------------------------------
#Descripciones

  ;Descripcion de ElectroR
  LangString DESC_ElectroR ${LANG_SPANISH} "Archivos necesarios para la ejecución de Electro R"

  ;Descripcion de Prerequisitos
  LangString DESC_Prerequisitos ${LANG_SPANISH} "Archivos necesarios para que Electro R funcione correctamente"

  ;Asignamos las descripciones a cada seccion
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${ElectroR} $(DESC_ElectroR)
    !insertmacro MUI_DESCRIPTION_TEXT ${Prerequisitos} $(DESC_Prerequisitos)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------