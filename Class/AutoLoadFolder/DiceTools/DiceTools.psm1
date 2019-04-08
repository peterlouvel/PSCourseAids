﻿USING Module DiceClass
Function Show-DiceRoll {
  Param (
    [Parameter(Mandatory=$true)]
    [int]$NumberOfDice,
    [Parameter(Mandatory=$true)]
    [int]$NumberOfSides,
    [Parameter(Mandatory=$true)]
    [int]$NumberOfRolls
  )
  $Dice = [Dice]::New($NumberOfDice,$NumberOfSides)
  1..$NumberOfRolls | ForEach-Object {
    $Dice.Roll() 
  }
}