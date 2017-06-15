#connect 4 Game

#variables used in all functions 


$roow = 5 #determines which row the last played coin is standing in   
$turn = 1 #sees which player turn is it {1 for red , 2 for yellow}

#empty board to fill it 
$connect = [
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil]
]






def draw #draws the board 
print "\t1\t |\t2\t |\t3\t |\t4\t |\t5\t |\t6\t |\t7\t |\n----------------------------------------------------------------------\n"
for row in 0..5
  for col in 0..6
   print "\t "
   print "#{$connect[row][col]} "
   print "\t |"
  end
  print "\n----------------------------------------------------------------------\n"
  #puts "this is the row elements of row #{row} which is --> #{$connect[row]}"
end
end


#function which is responsible for dropping the coin and determing the winner 
def drop(col)
  current = $connect[5] #by default the first coin will be in the fifth row
  if current[col] == nil #checkes if the column at that row is empty
    if $turn == 1 #filles for player 1 with red
      current[col] = 'R'
    else #filles it for player 2 with yellow
      current[col] = 'Y'
    end
  else
    for count in 5.downto(0) #cheackes if there's an empty row in the choosed column from row  6 to row 1 

      current = $connect[count] #updates the row to check if it's empty

      if count == 0 && current[col] != nil #return false if the whole column is full
        puts "This column is full !"
        return false
      end

      if current[col] == nil #filles the column if any row found empty
        $roow  = count
        if $turn == 1
          current[col] = 'R'
          break
        else
          current[col] = 'Y'
          break
        end

      end
    end
  end

win = 0
  for num in 1..2 #checkes the right side first
    for try in 1..3 #checks the three columns in both ways
      #checks right
      if num == 1 #checks right first
        if current[col] == current[col + try] && (current[col] != nil && current[col + try] != nil)
          win += 1
        else
          break
        end
      end
       if num == 2 #checks left
         break if col - try < 0 #breaks  if the index is negative
         if  current[col] == current[col - try] && (current[col] != nil && current[col - try] != nil)
           win += 1
         else
           break
         end
       end
    end
  end
  if win >= 3 #if theres a winner returns that winner 
    return $turn
  else
    win = 0 #returns winnig state to zero if there is no winner 
  end

  #the vertical search for winner starts 
  for num in 1..2
    for try in 1..3

      if num == 1
        
        if  $roow - try >= 0 #checkes if it reached the top of a column 
        up = $connect[$roow - try] #updates the row to the one above the current 
          if current[col] == up[col] && (current[col] != nil && up[col] != nil) 
            win += 1
          end
       else
         break
       end
       end

      if num == 2
        
        if $roow + try <= 5
         down = $connect[$roow + try] #updates to the one beneath the current 
          if current[col] == down[col] && (current[col] != nil && down[col] != nil)
            win += 1
          end
        else
          break
        end
      end

    end

  end
  if win >= 3

    return $turn
  else
    win = 0
  end
  
  #the diagonal search for winner starts 
  
for num in 1..2
  for try in 1..3
   if num == 1
     check = $roow - try
     check2= col + try
    if check >= 0 && check2 <= 6
      dig_up = $connect[$roow - try] #updates the diagonal above the current 
      if current[col] == dig_up[col + try] && (current[col] != nil && dig_up[col + try] != nil)
        win += 1
      end
    else
      break
    end
   end

    if num ==2
      check = $roow + try
      check2 = col - try
      if check <= 5 && check2 >= 0
        dig_down = $connect[$roow + try] #updates the diagonal beneath the current 
        if current[col] == dig_down[col - try]  && (current[col] != nil && dig_down[col - try] != nil)
          win += 1
        end
      else
        break
      end
    end
end

end
 if win >= 3
   return $turn
    else
   if $turn == 1
     $turn =2
   else
     $turn = 1
   end
  end
 return 0
end

#the first draw to make the player choose his first column 
draw


# the game loop starts here 
for turns in 1..42
  puts "Please Player #{$turn} choose a column to drop!"
  choice = gets.chomp.to_i
  $stat = drop(choice - 1)
  while !$stat && choice <= 7 #if the player choose an already chosen column or a number out of the range 
    puts "Please choose an empty column"
    choice = gets.chomp.to_i
    $stat = drop(choice - 1)
  end
  
  if $stat == 1 || $stat == 2 #if there is a winner the loop breaks 
    puts "We have a winner ! ! ! , player #{$turn}"
    break
  else
    print "--------------------------------------- Updated Boarded ------------------------ \n"
    draw
    next
  end

end

puts "its a draw " if $stat == 0 # if the loop finished this will be printed