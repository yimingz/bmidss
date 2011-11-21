class HomeController < ApplicationController
  def index

    require 'sqlite3'
    grayBegin=4
    basisBegin=1
    bmiBasisBegin=0
    count = 0
    genderString = params[:gender]
    raceString = params[:race]
    gender = genderString[0]
    race = raceString[0]
    db = SQLite3::Database.new( "db/patrick.sqlite3" )
    gray = db.get_first_row("select * from FullDataWeights where Gender='" + (gender) + "' and Age=" + params[:age].to_s + " and Race='" + (race) + "' and Year='" + params[:year].to_s + "' ")
  

    
    if params[:weight_kg].nil? 
      underweight = ((18.5 * (params[:height_feet].to_f*12 +params[:height_inch].to_f) * (params[:height_feet].to_f*12 +params[:height_inch].to_f)) / 703).round(0)    
      normal = ((25 * (params[:height_feet].to_f*12 +params[:height_inch].to_f) * (params[:height_feet].to_f*12 +params[:height_inch].to_f)) / 703).round(0)
      overweight = ((30 * (params[:height_feet].to_f*12 +params[:height_inch].to_f) * (params[:height_feet].to_f*12 +params[:height_inch].to_f)) / 703).round(0)
      obese = ((35 * (params[:height_feet].to_f*12 +params[:height_inch].to_f) * (params[:height_feet].to_f*12 +params[:height_inch].to_f)) / 703).round(0)    
      severe = ((40 * (params[:height_feet].to_f*12 +params[:height_inch].to_f) * (params[:height_feet].to_f*12 +params[:height_inch].to_f)) / 703).round(0)    
      
    else
      underweight = ((18.5 * (params[:height_cm].to_f / 2.54) * (params[:height_cm].to_f / 2.54)) / 703).round(0)
      normal = ((25 * (params[:height_cm].to_f / 2.54) * (params[:height_cm].to_f / 2.54)) / 703).round(0)
      overweight = ((30 * (params[:height_cm].to_f / 2.54) * (params[:height_cm].to_f / 2.54)) / 703).round(0)
      obese = ((35 * (params[:height_cm].to_f / 2.54) * (params[:height_cm].to_f / 2.54)) / 703).round(0)
      severe = ((40 * (params[:height_cm].to_f / 2.54) * (params[:height_cm].to_f / 2.54)) / 703).round(0)

    end
    
    underArray = []
    normalArray = []
    overweightArray = []
    obeseArray = []
    severeArray = []
    morbidArray = []
    
    underBMIArray = []
    normalBMIArray = []
    overweightBMIArray = []
    obeseBMIArray = []
    severeBMIArray = []
    morbidBMIArray = []
    
    underTotal = 0
    normalTotal = 0
    overweightTotal = 0
    obeseTotal = 0
    severeTotal = 0
    morbidTotal = 0
    
    underBMITotal = 0
    normalBMITotal = 0
    overweightBMITotal = 0
    obeseBMITotal = 0
    severeBMITotal = 0
    morbidBMITotal = 0
      
  if(params[:height_inch] != nil) #we are in US 
    height = Integer(params[:height_feet])
    height = height * 12
    height = height + Integer(params[:height_inch])
    result = []
    yours = []

    db.execute( "select * from BasisGraphs where Height=" + height.to_s) do |row|
      current = []
      curYours = []
      underCur = []
      normalCur = []
      overweightCur = []
      obeseCur = []
      severeCur = []
      morbidCur = []
      current << (count+75)
      curYours << (count+75)


      if(Integer(params[:weight_lb]) != count+75)
        curYours << 0
        point = (row.at(basisBegin+1)* gray.at(grayBegin+1)) + (row.at(basisBegin+2)*gray.at(grayBegin+2)) + (row.at(basisBegin+3)*gray.at(grayBegin+3)) + (row.at(basisBegin+4)*gray.at(grayBegin+4)) + (row.at(basisBegin+5)*gray.at(grayBegin+5)) + (row.at(basisBegin+6)*gray.at(grayBegin+6)) + (row.at(basisBegin+7)*gray.at(grayBegin+7)) + (row.at(basisBegin+8)*gray.at(grayBegin+8)) 
        current << Integer(point * gray.at(grayBegin))
      else
        point = (row.at(basisBegin+1)* gray.at(grayBegin+1)) + (row.at(basisBegin+2)*gray.at(grayBegin+2)) + (row.at(basisBegin+3)*gray.at(grayBegin+3)) + (row.at(basisBegin+4)*gray.at(grayBegin+4)) + (row.at(basisBegin+5)*gray.at(grayBegin+5)) + (row.at(basisBegin+6)*gray.at(grayBegin+6)) + (row.at(basisBegin+7)*gray.at(grayBegin+7)) + (row.at(basisBegin+8)*gray.at(grayBegin+8)) 
        curYours << Integer(point * gray.at(grayBegin))
        current << Integer(point * gray.at(grayBegin))

      end
      
      if(count+75 < underweight)
        underCur << (count+75)
        underCur << Integer(point * gray.at(grayBegin))
        underArray << underCur
        underTotal = underTotal+Integer(point * gray.at(grayBegin))
        
      elsif(count+75 == underweight )
        underCur << (count+75)
        underCur << Integer(point * gray.at(grayBegin))
        underArray << underCur
        normalCur << (count+75)
        normalCur << Integer(point * gray.at(grayBegin))
        normalArray << normalCur
        underTotal = underTotal+Integer(point * gray.at(grayBegin))
        
      elsif(count+75 < normal)
        normalCur << (count+75)
        normalCur << Integer(point * gray.at(grayBegin))
        normalArray << normalCur
        normalTotal = normalTotal+Integer(point * gray.at(grayBegin))
        
      elsif(count+75 == normal)
        normalCur << (count+75)
        normalCur << Integer(point * gray.at(grayBegin))
        normalArray << normalCur
        overweightCur << (count+75)
        overweightCur << Integer(point * gray.at(grayBegin))
        overweightArray << overweightCur
        normalTotal = normalTotal+Integer(point * gray.at(grayBegin))
        
      elsif(count+75 < overweight)
        overweightCur << (count+75)
        overweightCur << Integer(point * gray.at(grayBegin))
        overweightArray << overweightCur
        overweightTotal = overweightTotal+Integer(point * gray.at(grayBegin))
        
      elsif(count+75 == overweight) 
        overweightCur << (count+75)
        overweightCur << Integer(point * gray.at(grayBegin))
        overweightArray << overweightCur
        obeseCur << (count+75)
        obeseCur << Integer(point * gray.at(grayBegin)) 
        obeseArray << obeseCur
        overweightTotal = overweightTotal+Integer(point * gray.at(grayBegin))
      
      elsif(count+75 < obese)
        obeseCur << (count+75)
        obeseCur << Integer(point * gray.at(grayBegin)) 
        obeseArray << obeseCur
        obeseTotal = obeseTotal+Integer(point * gray.at(grayBegin))

      elsif(count+75 == obese)
        obeseCur << (count+75)
        obeseCur << Integer(point * gray.at(grayBegin)) 
        obeseArray << obeseCur
        severeCur << (count+75)
        severeCur << Integer(point * gray.at(grayBegin))
        severeArray << severeCur
        obeseTotal = obeseTotal+Integer(point * gray.at(grayBegin))
        
      elsif(count+75 < severe)
        severeCur << (count+75)
        severeCur << Integer(point * gray.at(grayBegin))
        severeArray << severeCur
        severeTotal = severeTotal+Integer(point * gray.at(grayBegin))
      
      elsif( count+75 == severe)
        severeCur << (count+75)
        severeCur << Integer(point * gray.at(grayBegin))
        severeArray << severeCur
        morbidCur << (count+75)
        morbidCur << Integer(point * gray.at(grayBegin))
        morbidArray << morbidCur
        severeTotal = severeTotal+Integer(point * gray.at(grayBegin))
        
      else
        morbidCur << (count+75)
        morbidCur << Integer(point * gray.at(grayBegin))
        morbidArray << morbidCur
        morbidTotal = morbidTotal+Integer(point * gray.at(grayBegin))
      end
    

      count = count + 1
      yours << curYours 
      result << current
    end
    
     #BMI RESULTS   
  
      height = Integer(params[:height_feet])
      height = height * 12
      height = height + Integer(params[:height_inch])
      count = 0
      bmi = ((Integer(params[:weight_lb]) * 703) / (height*height)).round(2)
      bmiResult = []
      yourBMI = []
      
      row = db.execute( "select * from BMIbasis") do |row|
        count = count+1
        currentBMI = []
        yourCurBMI = []
        underBMICur = []
        normalBMICur = []
        overweightBMICur = []
        obeseBMICur = []
        severeBMICur = []
        morbidBMICur = []

        

        currentBMI << ((count*0.5)+9.5)
        yourCurBMI << ((count*0.5)+9.5)


        if(bmi != ((count*0.5)+9.5))
          yourCurBMI << 0
          point = (row.at(bmiBasisBegin+1)* gray.at(grayBegin+1)) + (row.at(bmiBasisBegin+2)*gray.at(grayBegin+2)) + (row.at(bmiBasisBegin+3)*gray.at(grayBegin+3)) + (row.at(bmiBasisBegin+4)*gray.at(grayBegin+4)) + (row.at(bmiBasisBegin+5)*gray.at(grayBegin+5)) + (row.at(bmiBasisBegin+6)*gray.at(grayBegin+6)) + (row.at(bmiBasisBegin+7)*gray.at(grayBegin+7)) + (row.at(bmiBasisBegin+8)*gray.at(grayBegin+8)) 
          currentBMI << Integer(point * gray.at(grayBegin))
        else
          point = (row.at(bmiBasisBegin+1)* gray.at(grayBegin+1)) + (row.at(bmiBasisBegin+2)*gray.at(grayBegin+2)) + (row.at(bmiBasisBegin+3)*gray.at(grayBegin+3)) + (row.at(bmiBasisBegin+4)*gray.at(grayBegin+4)) + (row.at(bmiBasisBegin+5)*gray.at(grayBegin+5)) + (row.at(bmiBasisBegin+6)*gray.at(grayBegin+6)) + (row.at(bmiBasisBegin+7)*gray.at(grayBegin+7)) + (row.at(bmiBasisBegin+8)*gray.at(grayBegin+8)) 
          yourCurBMI << Integer(point * gray.at(grayBegin))
          currentBMI << Integer(point * gray.at(grayBegin))
        end
        
      if (((count*0.5)+9.5) < 18.5)
        underBMICur << ((count*0.5)+9.5)
        underBMICur << Integer(point * gray.at(grayBegin)) 
        underBMIArray << underBMICur
        underBMITotal = underBMITotal + Integer(point * gray.at(grayBegin))
      
      elsif (((count*0.5)+9.5) == 18.5)
        underBMICur << ((count*0.5)+9.5)
        underBMICur << Integer(point * gray.at(grayBegin)) 
        underBMIArray << underBMICur
        underBMITotal = underBMITotal + Integer(point * gray.at(grayBegin))
        
        normalBMICur << ((count*0.5)+9.5)
        normalBMICur << Integer(point * gray.at(grayBegin)) 
        normalBMIArray << normalBMICur

      elsif (((count*0.5)+9.5) < 25.0)
        normalBMICur << ((count*0.5)+9.5)
        normalBMICur << Integer(point * gray.at(grayBegin)) 
        normalBMIArray << normalBMICur
        normalBMITotal = normalBMITotal + Integer(point * gray.at(grayBegin))
          
      elsif (((count*0.5)+9.5) == 25.0)
        normalBMICur << ((count*0.5)+9.5)
        normalBMICur << Integer(point * gray.at(grayBegin)) 
        normalBMIArray << normalBMICur
        normalBMITotal = normalBMITotal + Integer(point * gray.at(grayBegin))
        overweightBMICur << ((count*0.5)+9.5)
        overweightBMICur << Integer(point * gray.at(grayBegin)) 
        overweightBMIArray << overweightBMICur
          
      elsif (((count*0.5)+9.5) < 30.0)
        overweightBMICur << ((count*0.5)+9.5)
        overweightBMICur << Integer(point * gray.at(grayBegin)) 
        overweightBMIArray << overweightBMICur
        overweightBMITotal = overweightBMITotal + Integer(point * gray.at(grayBegin))
      
      elsif (((count*0.5)+9.5) == 30.0)
        overweightBMICur << ((count*0.5)+9.5)
        overweightBMICur << Integer(point * gray.at(grayBegin)) 
        overweightBMIArray << overweightBMICur
        overweightBMITotal = overweightBMITotal + Integer(point * gray.at(grayBegin))
        obeseBMICur << ((count*0.5)+9.5)
        obeseBMICur << Integer(point * gray.at(grayBegin)) 
        obeseBMIArray << obeseBMICur
          
      elsif (((count*0.5)+9.5) < 35.0)
        obeseBMICur << ((count*0.5)+9.5)
        obeseBMICur << Integer(point * gray.at(grayBegin)) 
        obeseBMIArray << obeseBMICur
        obeseBMITotal = obeseBMITotal + Integer(point * gray.at(grayBegin))
        
      elsif (((count*0.5)+9.5) == 35.0)
        obeseBMICur << ((count*0.5)+9.5)
        obeseBMICur << Integer(point * gray.at(grayBegin)) 
        obeseBMIArray << obeseBMICur
        obeseBMITotal = obeseBMITotal + Integer(point * gray.at(grayBegin))
        severeBMICur << ((count*0.5)+9.5)
        severeBMICur << Integer(point * gray.at(grayBegin)) 
        severeBMIArray << severeBMICur
      elsif (((count*0.5)+9.5) < 40.0)
        severeBMICur << ((count*0.5)+9.5)
        severeBMICur << Integer(point * gray.at(grayBegin)) 
        severeBMIArray << severeBMICur
        severeBMITotal = severeBMITotal + Integer(point * gray.at(grayBegin))
      
      elsif (((count*0.5)+9.5) == 40.0)
        severeBMICur << ((count*0.5)+9.5)
        severeBMICur << Integer(point * gray.at(grayBegin)) 
        severeBMIArray << severeBMICur
        severeBMITotal = severeBMITotal + Integer(point * gray.at(grayBegin))
        morbidBMICur << ((count*0.5)+9.5)
        morbidBMICur << Integer(point * gray.at(grayBegin)) 
        morbidBMIArray << morbidBMICur        
      else
        morbidBMICur << ((count*0.5)+9.5)
        morbidBMICur << Integer(point * gray.at(grayBegin)) 
        morbidBMIArray << morbidBMICur
        morbidBMITotal = morbidBMITotal + Integer(point * gray.at(grayBegin))
      end
      
        yourBMI << yourCurBMI
        bmiResult << currentBMI
      end
      
  else # we are in Metric Mode
      
    height = (Integer(params[:height_cm]) * 0.393700787).round(0)
    weight = (Integer(params[:weight_kg])* 2.20462262).round(0)
    bmi = ((weight * 703) / (height*height)).round(2)
    result = []
    yours = []
    underCur = []
    normalCur = []
    overweightCur = []
    obeseCur = []
    severeCur = []
    morbidCur = []

    db.execute( "select * from BasisGraphs where Height=" + height.to_s) do |row|
      current = []
      curYours = []
      current << (count+75)
      curYours << (count+75)
      
      if(weight != count+75)
        curYours << 0
        point = (row.at(basisBegin+1)* gray.at(grayBegin+1)) + (row.at(basisBegin+2)*gray.at(grayBegin+2)) + (row.at(basisBegin+3)*gray.at(grayBegin+3)) + (row.at(basisBegin+4)*gray.at(grayBegin+4)) + (row.at(basisBegin+5)*gray.at(grayBegin+5)) + (row.at(basisBegin+6)*gray.at(grayBegin+6)) + (row.at(basisBegin+7)*gray.at(grayBegin+7)) + (row.at(basisBegin+8)*gray.at(grayBegin+8)) 
        current << Integer(point * gray.at(grayBegin))
      else
        point = (row.at(basisBegin+1)* gray.at(grayBegin+1)) + (row.at(basisBegin+2)*gray.at(grayBegin+2)) + (row.at(basisBegin+3)*gray.at(grayBegin+3)) + (row.at(basisBegin+4)*gray.at(grayBegin+4)) + (row.at(basisBegin+5)*gray.at(grayBegin+5)) + (row.at(basisBegin+6)*gray.at(grayBegin+6)) + (row.at(basisBegin+7)*gray.at(grayBegin+7)) + (row.at(basisBegin+8)*gray.at(grayBegin+8)) 
        curYours << Integer(point * gray.at(grayBegin))
        current << Integer(point * gray.at(grayBegin))

      end
    
    
      if(count+75 < underweight)
        underCur << (count+75)
        underCur << Integer(point * gray.at(grayBegin))
        underArray << underCur
        underTotal = underTotal + Integer(point * gray.at(grayBegin))
        
      elsif(count+75 == underweight )
        underCur << (count+75)
        underCur << Integer(point * gray.at(grayBegin))
        underArray << underCur
        normalCur << (count+75)
        normalCur << Integer(point * gray.at(grayBegin))
        normalArray << normalCur
        underTotal = underTotal + Integer(point * gray.at(grayBegin))
        
      elsif(count+75 < normal)
        normalCur << (count+75)
        normalCur << Integer(point * gray.at(grayBegin))
        normalArray << normalCur
        normalTotal = normalTotal + Integer(point * gray.at(grayBegin))
        
      elsif(count+75 == normal)
        normalCur << (count+75)
        normalCur << Integer(point * gray.at(grayBegin))
        normalArray << normalCur
        overweightCur << (count+75)
        overweightCur << Integer(point * gray.at(grayBegin))
        overweightArray << overweightCur
        normalTotal = normalTotal + Integer(point * gray.at(grayBegin))
        
      elsif(count+75 < overweight)
        overweightCur << (count+75)
        overweightCur << Integer(point * gray.at(grayBegin))
        overweightArray << overweightCur
        overweightTotal = overweightTotal + Integer(point * gray.at(grayBegin))
        
      elsif(count+75 == overweight) 
        overweightCur << (count+75)
        overweightCur << Integer(point * gray.at(grayBegin))
        overweightArray << overweightCur
        obeseCur << (count+75)
        obeseCur << Integer(point * gray.at(grayBegin)) 
        obeseArray << obeseCur
        overweightTotal = overweightTotal + Integer(point * gray.at(grayBegin))
      
      elsif(count+75 < obese)
        obeseCur << (count+75)
        obeseCur << Integer(point * gray.at(grayBegin)) 
        obeseArray << obeseCur
        obeseTotal = obeseTotal + Integer(point * gray.at(grayBegin))

      elsif(count+75 == obese)
        obeseCur << (count+75)
        obeseCur << Integer(point * gray.at(grayBegin)) 
        obeseArray << obeseCur
        severeCur << (count+75)
        severeCur << Integer(point * gray.at(grayBegin))
        severeArray << severeCur
        obeseTotal = obeseTotal + Integer(point * gray.at(grayBegin))
        
      elsif(count+75 < severe)
        severeCur << (count+75)
        severeCur << Integer(point * gray.at(grayBegin))
        severeArray << severeCur
        severeTotal = severeTotal + Integer(point * gray.at(grayBegin))
      
      elsif( count+75 == severe)
        severeCur << (count+75)
        severeCur << Integer(point * gray.at(grayBegin))
        severeArray << severeCur
        morbidCur << (count+75)
        morbidCur << Integer(point * gray.at(grayBegin))
        morbidArray << morbidCur
        severeTotal = severeTotal + Integer(point * gray.at(grayBegin))
        
      else
        morbidCur << (count+75)
        morbidCur << Integer(point * gray.at(grayBegin))
        morbidArray << morbidCur
        morbidTotal = morbidTotal + Integer(point * gray.at(grayBegin))
      end
      
    count = count + 1
    yours << curYours 
    result << current   
    end

     #BMI RESULTS   
     
      bmiResult = []
      yourBMI = []
      

      
      row = db.execute( "select * from BMIbasis") do |row|
      currentBMI = []
      yourCurBMI = []
      
      underBMICur = []
      normalBMICur = []
      overweightBMICur = []
      obeseBMICur = []
      severeBMICur = []
      morbidBMICur = []

      currentBMI << ((count*0.5)+9.5)
      yourCurBMI << ((count*0.5)+9.5)

      if(bmi != ((count*0.5)+9.5))
        yourCurBMI << 0
        point = (row.at(bmiBasisBegin+1)* gray.at(grayBegin+1)) + (row.at(bmiBasisBegin+2)*gray.at(grayBegin+2)) + (row.at(bmiBasisBegin+3)*gray.at(grayBegin+3)) + (row.at(bmiBasisBegin+4)*gray.at(grayBegin+4)) + (row.at(bmiBasisBegin+5)*gray.at(grayBegin+5)) + (row.at(bmiBasisBegin+6)*gray.at(grayBegin+6)) + (row.at(bmiBasisBegin+7)*gray.at(grayBegin+7)) + (row.at(bmiBasisBegin+8)*gray.at(grayBegin+8)) 
        currentBMI << Integer(point * gray.at(grayBegin))
      else
        point = (row.at(bmiBasisBegin+1)* gray.at(grayBegin+1)) + (row.at(bmiBasisBegin+2)*gray.at(grayBegin+2)) + (row.at(bmiBasisBegin+3)*gray.at(grayBegin+3)) + (row.at(bmiBasisBegin+4)*gray.at(grayBegin+4)) + (row.at(bmiBasisBegin+5)*gray.at(grayBegin+5)) + (row.at(bmiBasisBegin+6)*gray.at(grayBegin+6)) + (row.at(bmiBasisBegin+7)*gray.at(grayBegin+7)) + (row.at(bmiBasisBegin+8)*gray.at(grayBegin+8)) 
        yourCurBMI << Integer(point * gray.at(grayBegin))
        currentBMI << Integer(point * gray.at(grayBegin))
      end
      
      if (((count*0.5)+9.5) < 18.5)
        underBMICur << ((count*0.5)+9.5)
        underBMICur << Integer(point * gray.at(grayBegin)) 
        underBMIArray << underBMICur
        underBMITotal = underBMITotal + Integer(point * gray.at(grayBegin))
      elsif (((count*0.5)+9.5) == 18.5)
        underBMICur << ((count*0.5)+9.5)
        underBMICur << Integer(point * gray.at(grayBegin)) 
        underBMIArray << underBMICur
        underBMITotal = underBMITotal + Integer(point * gray.at(grayBegin))
        
        normalBMICur << ((count*0.5)+9.5)
        normalBMICur << Integer(point * gray.at(grayBegin)) 
        normalBMIArray << normalBMICur

      elsif (((count*0.5)+9.5) < 25.0)
        normalBMICur << ((count*0.5)+9.5)
        normalBMICur << Integer(point * gray.at(grayBegin)) 
        normalBMIArray << normalBMICur
        normalBMITotal = normalBMITotal + Integer(point * gray.at(grayBegin))
          
      elsif (((count*0.5)+9.5) == 25.0)
        normalBMICur << ((count*0.5)+9.5)
        normalBMICur << Integer(point * gray.at(grayBegin)) 
        normalBMIArray << normalBMICur
        normalBMITotal = normalBMITotal + Integer(point * gray.at(grayBegin))
        
        overweightBMICur << ((count*0.5)+9.5)
        overweightBMICur << Integer(point * gray.at(grayBegin)) 
        overweightBMIArray << overweightBMICur
          
      elsif (((count*0.5)+9.5) < 30.0)
        overweightBMICur << ((count*0.5)+9.5)
        overweightBMICur << Integer(point * gray.at(grayBegin)) 
        overweightBMIArray << overweightBMICur
        overweightBMITotal = overweightBMITotal + Integer(point * gray.at(grayBegin))
      
      elsif (((count*0.5)+9.5) == 30.0)
        overweightBMICur << ((count*0.5)+9.5)
        overweightBMICur << Integer(point * gray.at(grayBegin)) 
        overweightBMIArray << overweightBMICur
        overweightBMITotal = overweightBMITotal + Integer(point * gray.at(grayBegin))
        obeseBMICur << ((count*0.5)+9.5)
        obeseBMICur << Integer(point * gray.at(grayBegin)) 
        obeseBMIArray << obeseBMICur
          
      elsif (((count*0.5)+9.5) < 35.0)
        obeseBMICur << ((count*0.5)+9.5)
        obeseBMICur << Integer(point * gray.at(grayBegin)) 
        obeseBMIArray << obeseBMICur
        obeseBMITotal = obeseBMITotal + Integer(point * gray.at(grayBegin))
        
      elsif (((count*0.5)+9.5) == 35.0)
        obeseBMICur << ((count*0.5)+9.5)
        obeseBMICur << Integer(point * gray.at(grayBegin)) 
        obeseBMIArray << obeseBMICur
        obeseBMITotal = obeseBMITotal + Integer(point * gray.at(grayBegin))
        severeBMICur << ((count*0.5)+9.5)
        severeBMICur << Integer(point * gray.at(grayBegin)) 
        severeBMIArray << severeBMICur
      elsif (((count*0.5)+9.5) < 40.0)
        severeBMICur << ((count*0.5)+9.5)
        severeBMICur << Integer(point * gray.at(grayBegin)) 
        severeBMIArray << severeBMICur
        severeBMITotal = severeBMITotal + Integer(point * gray.at(grayBegin))
      
      elsif (((count*0.5)+9.5) == 40.0)
        severeBMICur << ((count*0.5)+9.5)
        severeBMICur << Integer(point * gray.at(grayBegin)) 
        severeBMIArray << severeBMICur
        severeBMITotal = severeBMITotal + Integer(point * gray.at(grayBegin))
        morbidBMICur << ((count*0.5)+9.5)
        morbidBMICur << Integer(point * gray.at(grayBegin)) 
        morbidBMIArray << morbidBMICur        
      else
        morbidBMICur << ((count*0.5)+9.5)
        morbidBMICur << Integer(point * gray.at(grayBegin)) 
        morbidBMIArray << morbidBMICur
        morbidBMITotal = morbidBMITotal + Integer(point * gray.at(grayBegin))
      end
      
      yourBMI << yourCurBMI
      bmiResult << currentBMI
      end
end
#  Weight Chart
    @h = LazyHighCharts::HighChart.new('graph') do |f|
#New Colors
f.series(:name=>'Weights Distribution', :color=>'#F5F5F5', :type=>'area', :data=>result)
       f.series(:name=>'Underweight', :color=>'#d4d624',:type=>'area', :data=> underArray )
       f.series(:name=>'Normal', :color=>'#9dd624',:type=>'area', :data=> normalArray )
       f.series(:name=>'Overweight', :color=>'#d66f24',:type=>'area', :data=> overweightArray )
       f.series(:name=>'Obese', :color=>'#d64624',:type=>'area', :data=> obeseArray )
       f.series(:name=>'Severely obese', :color=>'#d62424',:type=>'area', :data=> severeArray )
       f.series(:name=>'Morbidly obese', :color=>'#000000',:type=>'area', :data=> morbidArray )
       f.series(:name=>'Your Weight', :color=>'#D64524',:type=>'column', :data=> yours )
       
#       f.series(:name=>'Weights Distribution', :color=>'#F5F5F5', :type=>'area', :data=>result)
#       f.series(:name=>'Underweight', :color=>'#56a1ef',:type=>'area', :data=> underArray )
#       f.series(:name=>'Normal', :color=>'#4c8ed3',:type=>'area', :data=> normalArray )
#       f.series(:name=>'Overweight', :color=>'#427bb6',:type=>'area', :data=> overweightArray )
#       f.series(:name=>'Obese', :color=>'#376799',:type=>'area', :data=> obeseArray )
#       f.series(:name=>'Severely obese', :color=>'#2d537c',:type=>'area', :data=> severeArray )
#       f.series(:name=>'Morbidly obese', :color=>'#1f3a56',:type=>'area', :data=> morbidArray )
#       f.series(:name=>'Your Weight', :color=>'#D64524',:type=>'column', :data=> yours )
       
          f.options[:chart][:width] = '1080'  
          f.options[:chart][:inverted] = false
          f.options[:tooltip][:enabled] = true
          f.options[:legend][:layout] = "horizontal"
          f.options[:title][:text] = 'People with the same Gender, Age, Race, and Height as you'

          f.plotOptions(:series=>{:stickyTracking=>true,:animation=>{:duration=>4000,:easing=>'swing'}},
            :area=>{:marker=>{:enabled=>false}},:column=>{:groupPadding=>0,:borderWidth=>0, :marker=>{:lineWidth=>5}})
          f.exporting(:buttons=>{:enabled=>true, :exportButton=>{:enabled=>true}})
          f.navigation(:buttonOptions=>{:align=>'center',:hoverSymbolStroke=>'blue',:enabled=>true})
          f.yAxis(:title=>{:text=>'Number of People'})
          f.xAxis(:title=>{:text=>'Weight'})
          f.tooltip(:crosshairs=>[{:color=>'green'},{:color=>'green'}])
    end
#    BMI Chart
        @h2 = LazyHighCharts::HighChart.new('graph') do |f| 
          f.series(:name=>'BMIs Distribution', :type=>'area', :color=>'#F5F5F5', :data=>bmiResult)
          f.series(:name=>'Underweight', :color=>'#d4d624',:type=>'area', :data=> underBMIArray )
          f.series(:name=>'Normal', :color=>'#9dd624',:type=>'area', :data=> normalBMIArray )
          f.series(:name=>'Overweight', :color=>'#d66f24',:type=>'area', :data=> overweightBMIArray )
          f.series(:name=>'Obese', :color=>'#d64624',:type=>'area', :data=> obeseBMIArray )
          f.series(:name=>'Severely obese', :color=>'#d62424',:type=>'area', :data=> severeBMIArray )
          f.series(:name=>'Morbidly obese', :color=>'#000000',:type=>'area', :data=> morbidBMIArray )
          f.series(:name=>'Your Body Mass Index (BMI)', :color=>'#D64524', :type=>'column', :data=> yourBMI )
           

          f.options[:chart][:width] = '1080'  
          f.options[:chart][:inverted] = false
          f.options[:tooltip][:enabled] = true
          f.options[:legend][:layout] = "horizontal"
          f.options[:title][:text] = 'People with the same Gender, Age, and Race as you'

                    f.plotOptions(:series=>{:stickyTracking=>true,:animation=>{:duration=>4000,:easing=>'swing'}},
            :area=>{:marker=>{:enabled=>false}},:column=>{:groupPadding=>0,:borderWidth=>0, :pointWidth=>5, :marker=>{:lineWidth=>0.1}})
      f.yAxis(:title=>{:text=>'Number of People'})
          f.xAxis(:title=>{:text=>'Body Mass Index (BMI)'})
          f.tooltip(:crosshairs=>[{:color=>'green'},{:color=>'green'}])
    end
  end

end
