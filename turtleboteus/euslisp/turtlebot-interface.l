;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 台車ロボットのrobot-interfaceクラス
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "package://pr2eus/robot-interface.l")
(require "package://turtleboteus/euslisp/turtlebot-with-sensors-robot.l")

;; loadする台車のrobot-interfaceクラスのメソッド定義ファイル
(require "package://turtleboteus/euslisp/turtlebot-interface-common.l")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 台車ロボットのrobot-interfaceクラス定義
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defclass turtlebot-interface
  :super robot-interface
  :slots ())

(defmethod turtlebot-interface
  (:init
   (&rest args)
   (eval `(defmethod ,(send (class self) :name)
            ,@(get-method-list-for-turtlebot-interface)
            ))
   (prog1
       (send-super* :init :robot turtlebot-with-sensors-robot args)
     (send self :initialize-turtlebot-ros)
     )
   )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; アーム台車ロボット用初期化関数
;;   robot-interface (*ri*) とモデル (*turtlebot*)を生成する
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun turtlebot-init (&key (objects))
  "Initialization function for *ri* and *turtlebot*."
  (if (not (boundp '*ri*))
      (setq *ri* (instance turtlebot-interface :init :objects objects)))
  (if (not (boundp '*turtlebot*))
      (setq *turtlebot* (turtlebot-with-sensors)))
  (objects (list *turtlebot*))
  (send *irtviewer* :change-background #f(0.9 0.9 0.9))
  (send *irtviewer* :draw-objects)
  )
(warn ";; (turtlebot-init) ;; for initialize ~%")