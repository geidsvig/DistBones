package com.geidsvig

/**
 * Bootstrap for DistBones Akka microkernel.
 */
class DistBonesBoot extends akka.kernel.Bootable {
  def startup = {
    
    val config = com.typesafe.config.ConfigFactory.load()
    println("Boot successful")

  }

  def shutdown = {

  }
}

