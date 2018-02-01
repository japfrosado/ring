/*
 *	
 *	frAddBs()		Adds a backslash (if needed) to a path expression.
 *	frALines()		Creates an Array with the content of the specified string. 
 *	frAllTrim()		Removes all leading and trailing spaces of the specified string. 
 *	frAt()			Searches a character expression for the occurrence of another character expression.
 *	frBetween()		Determines whether the value of an expression is inclusively between the values of two expressions of the same type.
 *	frEmpty()		Determines whether an expression evaluates to empty.
 *	frForceExt()		Returns a string with the old file name extension replaced by a new extension.
 *  	frIif()   		Returns one of two values depending on the value of a logical expression.
 *	frInList()		Determines whether an expression matches another expression in a list.
 *	frInt()			Evaluates a numeric expression and returns the integer portion of the expression.
 *	frJustFName()		Returns the file name portion of a complete path and file name.
 *	frJustPath()		Returns the path portion of a complete path and file name.
 *	frLen()			Determines the number of characters in a character expression, indicating the length of the expression.
 *	frListToString()	Creates a string with the string elements of an Array.
 *	frLTrim()		Removes all leading spaces or parsing characters from the specified character expression.
 *	frPadL()		Returns a string from an expression, padded with spaces or characters to a specified length on the left side.
 *	frPadR()		Returns a string from an expression, padded with spaces or characters to a specified length on the right side.
 *	frReplicate()		Returns a character string that contains a specified character expression repeated a specified number of times.
 *	frRTrim()		Removes all trailing spaces or parsing characters from the specified character expression.
 *	frSetIfEmpty()		Set a Value into a variable if the variable value is empty, null or zero.
 *	frSetSeparatorTo()	Specifies the character for the numeric place separator.
 *	frSpace()		Returns a character string composed of a specified number of spaces.
 *	frStr()			Returns the character equivalent of a numeric expression.
 *	frStringToList()	Creates a List with the content of the specified string.
 *	frStrTran()		Searches a character expression for a second character expression and replaces each occurrence with a third 
 *				character expression.			
 *	frSubStr()		Returns a character string from the given character expression, starting at a specified position in the character 
 *				expression and continuing for a specified number of characters.			
 * 	frTransform()		Returns a character string from an expression in a format determined by a format code.
 *	frVal()			Returns a numeric value from a character expression composed of numbers.
 *	frVarType()		Returns the data type of an expression.
 *
 */
	
	/*
	 * Syntax		: 
	 * Description		: 
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 * Remarks		: 
	 * Author	 	:
	 * History		:
	 */
	
class frFunctions

	_version = "1.0.135"

	_character_type = "C"
	_numeric_type = "N"	
	_list_type = "A"
	_object_type = "O"
	_undefined_type = "U"
	
	_decimal_point = "."		
	_empty_char = ""
	_space = " "
	_back_slash = "\"
	_separator = ","

	_ring_character_type 	= "STRING"
	_ring_numeric_type 	= "NUMBER"
	_ring_list_type 	= "LIST"
	_ring_object_type 	= "OBJECT"

	_set_separator 		= _separator

	/*
	 * Syntax		: lcReturnValue = frAddBs(tcPath)
	 * Description		: Adds a backslash (if needed) to a path expression.
	 *			:
	 * Arguments   		: <tcPath>
	 *			: Specifies the path name to which to add the backslash.
	 *			:
	 * Returns		: <lcReturnValue> The path with the backslash.
	 *			:
	 * Author	 	: Jar C 15.09.2017
	 */

	func frAddBs(tcPath) {
		return this.frStrTran(tcPath + this._back_slash, this.frReplicate(this._back_slash, 2), this._back_slash)
	}

	/*
	 * Syntax		: lnPos = frAt(tcToSearch, tcString, tnOccurrence)
	 * Description		: Searches a character expression for the occurrence of another character expression. 
	 *			: The search performed by .frAt() is case-sensitive.
	 *			:
	 * Arguments   		: <tcToSearch>
	 *			: Specifies the character expression to search for in tcString.
	 *			:
	 *			: <tcString> 
	 *			: Specifies the character expression to search for tcToSearch. 
	 *			:
	 *			: <tnOccurrence> 
	 *			: Specifies which occurrence, first, second, third, and so on, of tcToSearch to search for in tcString. 
	 *			: By default, .frAt() searches for the first occurrence of tcToSearch (tnOccurrence = 1). 
	 *			: 
	 * Returns		: Numeric. .frAt() returns an integer indicating the position of the first character for a character expression
	 *			: or memo field within another character expression or memo field, beginning from the leftmost character. If the 
	 *			: expression or field is not found, or if tnOccurrence is greater than the number of times tcToSearch occurs in 
	 *			: tcString, .frAt() returns 0.
	 *			:
	 * Author	 	: Jar c 19.12.2017
	 */

	func frAt(tcToSearch, tcString, tnOccurrence) {
	
		tnOcurrence 	= this.frSetIfEmpty(tnOccurrence, 1)
		lnRet 		= 0
		lnCounted 	= 0
		
		for n = 1 to tnOccurrence {
			lnRet = SubStr(tcString, tcToSearch)
			if lnRet > 0 {
				tcString = SubStr(tcString, lnRet + 1)
				if n < tnOccurrence {
					lnCounted += lnRet
				}
			else
				lnCounted = 0
			}
		}
		
		return lnCounted + lnRet
	}

	/*
	 * Syntax		: llReturnValue = frEmpty(tuExpression)
	 * Description		: Determines whether an expression evaluates to empty.
	 *			:
	 * Arguments   		: <tuExpression>
	 *			: Specifies the expression that EMPTY() evaluates. You can specify an expression with Character, 
	 *			: Numeric, or logical type.
	 *			:
	 * Returns		: <llReturnValue> Logical
	 *			:
	 * Author	 	: Jar C 06.09.2017
	 */

	func frEmpty(tuExpression) {
	
		llRet = False
	
		if IsNull(tuExpression) {
			llRet = True
		else
			lcExpressionType = this.frVarType(tuExpression)
			
			if lcExpressionType = this._character_type {
				if IsSpace(tuExpression) {
					llRet = True
				}
			else
				if lcExpressionType = this._numeric_type {
					if tuExpression = 0 {
						llRet = True
					}
				}
			}
		}
		
		return llRet
	}

	/*
	 * Syntax		: lcReturnValue = frStr(tnValue, tnLen, tnDec)
	 * Description		: Returns the character equivalent of a numeric expression.
	 *			:
	 * Arguments	   	: <tnValue>
	 *			: Specifies the numeric expression to evaluate.
	 *			: 
	 *			: <tnLen>
	 *			: Specifies the length of the character string returned. If tnLen is 0, tnLen defaults to 10 characters. 
	 *			: If tnLen < 0 returns one string with same length as the number.
	 *			: Note  
	 *			: If the expression contains a decimal point, the length includes one character for the decimal point and one character 
 	 *			: for each digit in the character string.
	 *			: 
	 *			: <tnDec> 
	 *			: Specifies the number of decimal places in the character string returned. To specify the number of decimal places using 
	 *			: tnDec, you must include nLength. If nDecimalPlaces is omitted, the number of decimal places defaults to zero (0). 
	 *			: 
	 * Returns		: Character data type. frStr() returns a character string equivalent to the specified numeric expression. 
	 *			: 
	 *			: Depending on certain conditions, frStr() can return the following: 
	 *			: If you specify fewer decimal places than exist in tnValue, the return value is rounded up. To round results to the nearest 
	 *			: decimal place instead of upward, include the ROUND( ) function. For more information, see ROUND( ) Function.
	 *			: If nExpression is an integer, and nLength is less than the number of digits in nExpression, frStr( ) returns a string of 
	 *			: asterisks, indicating numeric overflow.
	 *			: If nExpression contains a decimal point, and nLength is equal to or less than the number of digits to the left of the decimal
	 *			: point, frStr( ) returns a string of asterisks, indicating numeric overflow.
	 *			: If nLength is greater than the length of the value evaluated by nExpression, frStr( ) returns a character string padded with
	 * 			: leading spaces.
	 *			: If nExpression has Numeric or Float type, and nLength is less than the number of digits in nExpression, and , frStr( ) 
	 *			: returns a value using scientific notation. 
	 *			: 
	 * Author	 	: Jar 05.12.2017
	 */

	func frStr(tnValue, tnLen, tnDec) {

		lcZeroAsString = "0"
		lcDecimalPoint = this._decimal_point
		laList = []
		lnElements = this.frALines(laList, String(tnValue), lcDecimalPoint)

		if lnElements = 1 {
			Add(laList, lcZeroAsString)
		}
	
		if tnDec > 0 {
			laList[2] = Left(laList[2] + Copy(lcZeroAsString, tnDec), tnDec)
			lcRet = laList[1] + lcDecimalPoint + laList[2]
		else
			lcRet = laList[1]
		}

		if tnLen < 0 {
			lcRet = Trim(lcRet)	
		else
			tnLen = this.frSetIfEmpty(tnLen, 10)
			lcRet = Right(Copy(this._space, tnLen) + lcRet, tnLen)
		}

		return lcRet 
	}	

	/*
	 * Syntax		: tuReturnValue = frSetIfEmpty(tuValue, tuNewValue)
	 * Description		: Set a Value into a variable if the variable value is empty, null or zero.
	 *			:
	 * Arguments   		: <tuValue>
	 *			: The value to evaluate.
	 *			:
	 *			: <tuNewValue>
	 *			: The value to set if tuValue is empty.
	 *			:
	 * Returns		: tuNewValue if tuValue is empty, otherwise returns the original value.
	 *			:
	 * Remarks		: This function doesn't exist in VFP.
	 *			:
	 * Author	 	: Jar C 12.09.2017
	 */

	func frSetIfEmpty(tuValue, tuNewValue) {

		if this.frEmpty(tuValue) {
			tuValue = tuNewValue
		}
		return tuValue
	}

	/*
	 * Syntax		: lcReturnValue = frSpace(tnSpaces)
	 * Description		: Returns a character string composed of a specified number of spaces.
	 *			:
	 * Arguments   		: <tnSpaces>
	 *			: Specifies the number of spaces that frSpace() returns.
	 *			:
	 * Returns		: <lcReturnValue> 
	 *			: Character
	 *			:
	 * Author	 	: Jar C 07.01.2018
	 */

	func frSpace(tnSpaces) {
		return Copy(this._space, tnSpaces)
	}

	/*
	 * Syntax		: llReturnValue = frInList(tuExpression, taList)
	 * Description		: Determines whether an expression matches another expression in a set of expressions.
	 *			:
	 * Arguments   		: <tuExpression>
	 *			: Specifies the expression frInList() searches for in the List.
	 *			:
	 *			: <taList>
	 *			: Specifies the List of expressions to search. You must include at least one element in the list.
	 *			: The expressions in the list of expressions needn't to be of the same data type. 
	 *			:
	 * Returns		: <luReturnValue> Null or logical value.
	 *			:
	 * Author	 	: Jar C 12.01.2018
	 */

	func frInList(tuExpression, taList) {

		if tuExpression = Null {
			llReturn = Null
		else
			llReturn = False
			
			for x in taList {
			
				if Type(tuExpression) = Type(x) {
					if tuExpression = x {
						llReturn = True
					}
				}
			}
		}
		return llReturn 
	}

	/*
	 * Syntax		: lcRet = frVarType(tuExpression)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 01.09.2017
	 */

	func frVarType(tuExpression) {

		lcRet = this._undefined_type
		lcExpressionType = Type(tuExpression)

		if lcExpressionType = this._ring_character_type {
			lcRet = this._character_type
		else
			if lcExpressionType = this._ring_numeric_type {
				lcRet = this._numeric_type
			else
				if lcExpressionType = this._ring_list_type {
					lcRet = this._list_type
				else
					if lcExpressionType = this._ring_object_type {
						lcRet = this._object_type
					}
				}
			}
		}
	
		return lcRet
	}	

	/*
	 * Syntax		: lcReturnValue = frAllTrim(tcExpression, tcCharacter)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar 09.09.2017
	 */

	func frAllTrim(tcExpression, tcCharacter) {
	
		tcCharacter = this.frSetIfEmpty(tcCharacter, this._space)
	
		return this.frRTrim(this.frLTrim(tcExpression, tcCharacter), tcCharacter)
	}

	/*
	 * Syntax		: lcRet = frLTrim(tcExpression, tcCharacter)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 05.09.2016
	 */

	func frLTrim(tcExpression, tcCharacter) {

		lcRet = this._empty_char
		if not this.frEmpty(tcExpression) {

			lnLenExpression = Len(tcExpression)
			tcCharacter = this.frSetIfEmpty(tcCharacter, this._space)
			if lnLenExpression > 0 {
				for i = 1 to lnLenExpression {
					if SubStr(tcExpression, i, 1) != tcCharacter {
						for n = i to lnLenExpression {
							lcRet += SubStr(tcExpression, n, 1)
						}
						exit
					}
				}
			}	
		}
			
		return lcRet
	}	

	/*
	 * Syntax		: lcRet = frRTrim(tcExpression, tcCharacter)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar 05.09.2017
	 */

	func frRTrim(tcExpression, tcCharacter) {

		lcRet = this._empty_char
		if not this.frEmpty(tcExpression) {

			lnLenExpression = Len(tcExpression)
			tcCharacter = this.frSetIfEmpty(tcCharacter, this._space)
			if lnLenExpression > 0 {
				for i = lnLenExpression to 1 step -1 {
					if SubStr(tcExpression, i, 1) != tcCharacter {
						for n = 1 to i {
							lcRet += SubStr(tcExpression, n, 1)
						}
						exit
					}
				}
			}
		}
			
		return lcRet
	}

	/*
	 * Syntax		: tcReturnValue = frJustPath(tcExpression)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 08.10.2017
	 */

	func frJustPath(tcExpression) {

		laList = []
		lnElements = this.frALines(laList, tcExpression, this._back_slash)
		lcRet = this._empty_char
	
		for i = 1 to lnElements - 1 {
			lcRet = lcRet + laList[i] + this._back_slash
		}	
	
		return Left(lcRet, Len(lcRet) - 1)
	}	

	/*
	 * Syntax		: tcReturnValue = frForceExt(tcFileName, tcNewExtension)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 08.09.2017
	 */

	func frForceExt(tcFileName, tcNewExtension) {

		laList = []
		lcSeparator = "."
		this.frALines(laList, tcFileName, lcSeparator)
	
		return laList[1] + lcSeparator + tcNewExtension
	}

	/*
	 * Syntax		: tnReturnValue = frALines(taList, tcExpression, tcSeparator)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 07.09.2017
	 */

	func frALines(taList, tcExpression, tcSeparator) {

		taList = Str2List(SubStr(tcExpression, tcSeparator, nl))
	
		return Len(taList)
	}

	/*
	 * Syntax		: tcReturnValue = frJustFName(tcExpression)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 08.10.2017
	 */

	func frJustFName(tcExpression) {	

		laList = []
		lnElements = this.frALines(laList, tcExpression, this._back_slash)

		return laList[lnElements]
	}

	/*
	 * Syntax		: tcReturnValue = frPadL(tcString, tnLen, tcChar)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 06.12.2017
	 */

	func frPadL(tcString, tnLen, tcChar) {
		return Right(Copy(this.frSetIfEmpty(tcChar, this._space), tnLen) + tcString, tnLen)
	}

	/*
	 * Syntax		: tcReturnValue = frPadR(tcString, tnLen, tcChar)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 18.12.2017
	 */

	func frPadR(tcString, tnLen, tcChar) {
		return Left(tcString + Copy(this.frSetIfEmpty(tcChar, this._space), tnLen), tnLen)
	}

	/*
	 * Syntax		: tcReturnValue = frReplicate(tcString, tnTimes)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 07.09.2017
	 */

	func frReplicate(tcString, tnTimes) {
		return Copy(tcString, tnTimes)
	}

	/*
	 * Syntax		: tnReturnValue = frLen(tcString)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 11.10.2017
	 */

	func frLen(tcString) {
		return Len(tcString)
	}

	/*
	 * Syntax		: tcReturnValue = frSubStr(tcString, tnInitialPosition, tnNumberBytes)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 05.11.2017
	 */

	func frSubStr(tcString, tnInitialPosition, tnNumberBytes) {
	
		lcRet = this._empty_char
		if this.frEmpty(tnNumberBytes) {
			lcRet = SubStr(tcString, tnInitialPosition)
		else
			lcRet = SubStr(tcString, tnInitialPosition, tnNumberBytes)
		}
		
		return lcRet
	}

	/*
	 * Syntax		: tcReturnValue = frStrTran(tcString, tcOldString, tcNewString)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 12.09.2017
	 */

	func frStrTran(tcString, tcOldString, tcNewString) {
		return SubStr(tcString, tcOldString, tcNewString)
	}

	/*
	 * Syntax		: lcRet = frListToString(taList)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			:
	 * Remarks		: This function doesn't exist in VFP.
	 *			:
	 * Author	 	: Jar C 04.11.2017
	 */

	func frListToString(taList) {
		
		lcRet = this._empty_char
		for lcX in taList {
			lcRet += lcX
		}
		return lcRet
	}		

	/*
	 * Syntax		: lnInt = frInt(tnExpression)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			:
	 * Author	 	: Jar C 23.01.2018
	 */

	func frInt(tnExpression) {
		return this.frVal(this.frStr(tnExpression, 16, Null))
	}

	/*
	 * Syntax		: laList = frStringToList(tcExpression)
	 * Description		: 
	 *			:
	 * Arguments   		: 
	 *			: 
	 * Returns		: 
	 *			:
	 * Remarks		: This function doesn't exist in VFP.
	 *			:
	 * Author	 	: Jar C 07.09.2017
	 */

	func frStringToList(tcExpression) {
		laList = []
		for lcX in tcExpression {
			Add(laList, lcX)
		}
		return laList
	}

	/*
	 * Syntax		: luReturnValue = frIIf(tlExpression, tuReturnIfTrue, tuReturnIfFalse)
	 * Description		: Returns one of two values depending on the value of a logical expression.
	 *			:
	 * Arguments   		: <tlExpression>
	 *			: Specifies the logical expression that frIIf() evaluates.
	 *			:
	 *			: <tuReturnTrue>, <tuReturnFalse>
	 *			: If tlExpression evaluates to True, tuReturnIfTrue is returned and tuReturnIfFalse is not evaluated. 
	 *			: If tlExpression evaluates to False or Null, tuReturnIfFalse is returned and tuReturnIfTrue is not evaluated.
	 *			: 
	 * Returns		: <luReturnValue> Defined by <tuReturnIfTrue> or <tuReturnIfFalse>
	 *			: 
	 * Author	 	: Jar C 05.10.2017
	 */

	func frIIf(tlExpression, tuReturnIfTrue, tuReturnIfFalse) {
	
		if IsNull(tlExpression) {
			tuReturnValue = tuReturnIfFalse
		else
			if tlExpression {
				tuReturnValue = tuReturnIfTrue
			else
				tuReturnValue = tuReturnIfFalse
			}
		}
		return tuReturnValue
	}

	
	

	/*
	 * Syntax		: luReturnValue = frVal(tcExpression)
	 * Description		: Returns a numeric value from a character expression composed of numbers
	 *			:
	 * Arguments   		: <tcExpression>
	 *			: Specifies a character expression composed of up to 16 numbers.
	 *			:
	 * Returns		: <tnValue>
	 *			: Return a numeric value. 
	 *			: 
	 * Author	 	: Jar C 05.10.2017
	 */

	func frVal(tcExpression) {
		return Number(this.frAllTrim(tcExpression, Null))
	}



	/*
	 * Syntax		: luReturnValue = frBetween(tuTestValue, tuLowValue, tuHighValue)
	 * Description		: Determines whether the value of an expression is inclusively between the 
	 *			: values of two expressions of the same type.
	 *			:
	 * Arguments   		: <tuTestValue>
	 *			: Specifies an expression to evaluate.
	 *			:
	 *			: <tuLowValue>
	 *			: Specifies the lower value in the range.
	 *			:
	 *			: <tuHighValue>
	 *			: Specifies the higher value in the range.
	 *			:
	 * Returns		: <luReturnValue>
	 *			: Returns a logical oder null value. 
	 *			: 
	 * Author	 	: Jar C 29.01.2018
	 */

	func frBetween(tuTestValue, tuLowValue, tuHighValue) {

		llOk = True
		if IsNull(tuTestValue) or IsNull(tuLowValue) or IsNull(tuHighValue) {
			luRet = Null
			llOk = False
		}
		
		if llOk {
			if tuTestValue >= tuLowValue and tuTestValue <= tuHighValue {
				luRet = True
			else
				luRet = False
			}
		}
		
		return luRet
    	}

	

	/*
	 * Syntax		: frSetSeparatorTo(tuExpression)
	 * Description		: Specifies the character for the numeric place separator.
	 *			:
	 * Arguments   		: <tuExpression>
	 *			: Specifies the character for the numeric place separator. 
	 *			:
	 *			: Use frSetSeparatorTo() to change the numeric place separator from de default, for example space " " or a comma ",".
	 *			: Issue frSetSeparatorTo(Null) to reset the value to its default.
	 *			:
	 * Returns		: None
	 *			:  
	 *			: 
	 * Author	 	: Jar C 30.01.2018
	 */

	func frSetSeparatorTo(tuExpression) {

		if IsNull(tuExpression) {
			this._set_separator = this._separator
		}
		
		if this.frVarType(tuExpression) = this._character_type {
			this._set_separator = tuExpression
		}
    	}
	
	

	/*
	 * Syntax		: tcReturnValue = frTransform(tuExpression, tcFormatCodes)
	 * Description		: Returns a character string from an expression in a format determined by a format code.
	 *			:
	 * Arguments   		: <tuExpression>
	 *			: Specifies the expression to format.
	 *			:
	 *			: <tcFormatCodes>		
	 *			: Specifies one or more format codes that determine how to format the expression. 
	 *			: 
	 *			: Note
	 *			: The following table lists the available format codes for tcFormatCodes.
	 *			: 
	 *			:  ---------------------------------------------------------------------------------------
	 *			:	Format Code	Description
	 *			:  ---------------------------------------------------------------------------------------
	 *			: 	@!			Converts an entire character string to uppercase.
	 *			:  	@T 			Trims leading and trailing spaces from character values.
	 *			: 	@B			Left-justifies Numeric data within the display region.
	 *			:  ---------------------------------------------------------------------------------------
	 *			: 
	 * Returns		: 
	 *			: 
	 * Author	 	: Jar C 08.01.2018
	 *			: Jar U 02.01.2018 Add "@L" function
	 */

	func frTransform(tuExpression, tcFormatCodes) {
	
		tcReturnValue = this._empty_char
		if IsNull(tcFormatCodes) {
			tcReturnValue = this._empty_char + tuExpression
		else
			if tcFormatCodes = this._empty_char {
				tcReturnValue = this._empty_char + tuExpression
			else
				lcFunction = this._empty_char
				lcFormat = this._empty_char
				llOk = True
				if Left(tcFormatCodes, 1) != "@" {
					lcFormat = tcFormatCodes
				else
					lnPos = this.frAt(this._space, tcFormatCodes, 1)
					if lnPos = 0 {
						lcFunction = tcFormatCodes
						lcFormat = ""
					else
						lcFunction = left(tcFormatCodes, lnPos - 1)
						lcFormat = this.frSubStr(tcFormatCodes, lnPos + 1, 0)
					}
				}
				
				if this.frVarType(tuExpression) = this._character_type and llOk {
				
					laPictureCodes = ["9", "X", "!", "x", "A", "a", "#"]
				
					if Len(this.frAllTrim(lcFunction, Null)) = 2 {
						if llOk and Left(lcFunction, 2) = "@!" {
							llOk = False
							tcReturnValue = this._process_format_for_string(Upper(tuExpression), lcFormat, laPictureCodes)
						}
						if llOk and Left(lcFunction, 2) = "@T" {
							llOk = False
								
							/*
							 * This was the original code but the compiler returns an error. 
							 * However the problem was solved with two lines of code instead one.
							 *
							 * tcReturnValue = this._process_format_for_string(this.frAllTrim(tuExpression, Null), lcFormat, laPictureCodes)
							 */
							lcValue = this.frAllTrim(tuExpression, Null)
							tcReturnValue = this._process_format_for_string(lcValue, lcFormat, laPictureCodes)
						}
						if llOk and Left(lcFunction, 2) = "@L" {
							llOk = False
							lcValue = this.frAllTrim(tuExpression, Null)
							tcReturnValue = this.frPadL(this.frAllTrim(this._process_format_for_string(lcValue, lcFormat, laPictureCodes), 
												Null), Len(lcFormat), "0")
						}
					else
						if Len(this.frAllTrim(lcFunction, Null)) = 3 {
						
						}
					}
				else
					if this.frVarType(tuExpression) = this._numeric_type and llOk {
		
						lnOriginalExpression = tuExpression
						laPictureCodes = ["9", "#"]		
						tuExpression = this._empty_char + tuExpression
						
						if Len(this.frAllTrim(lcFunction, Null)) = 2 {

							if llOk and Left(lcFunction, 2) = "@B" {
								llOk = False
								lcValue = this.frAllTrim(tuExpression, Null)
								lcValue = this.frPadR(lcValue, 16, Null)
								tcReturnValue = this._process_format_for_numeric(lcValue, lcFormat, laPictureCodes)
							}
							
							if llOk and Left(lcFunction, 2) = "@C" {
								llOk = False
								lcValue = this.frAllTrim(tuExpression, Null)
								lcValue = this.frPadL(lcValue, 19, Null)
								tcReturnValue = this._process_format_for_numeric(lcValue, lcFormat, laPictureCodes)
								if lnOriginalExpression > 0 {
									tcReturnValue += " CR"
								}
							}
							
							if llOk and Left(lcFunction, 2) = "@L" {
								llOk = False
								lcValue = this.frAllTrim(tuExpression, Null)
								lcValue = this.frPadR(lcValue, 16, Null)
								tcReturnValue = this.frPadL(this.frAllTrim(this._process_format_for_numeric(lcValue, lcFormat, laPictureCodes), 
																Null), Len(lcFormat), "0")
							}
							
						}
						
						if Len(this.frAllTrim(lcFunction, Null)) = 0 {
							lcValue = this.frAllTrim(tuExpression, Null)
							lcValue = this.frPadL(lcValue, 19, Null)
							tcReturnValue = this._process_format_for_numeric(lcValue, lcFormat, laPictureCodes)
						}

						if Len(this.frAllTrim(lcFunction, Null)) = 3 {
							
						}
					}
				}
			}
		}
		return tcReturnValue
	}


	/*
	 * private functions and properties for this class
	 */

	private
	
	
	func _process_format_for_string(tcValue, tcFormat, taValidChars)
	
		lcRet = tcValue
		if Len(tcFormat) > 0 {
			lcRet = ""
			lnPos = 1
			for v in tcFormat {
				if this.frInList(v, taValidChars) {
					lcChar = this.frSubStr(tcValue, lnPos, 1)
					if v = "!" {
						lcChar = Upper(lcChar)
					}
				else
					lcChar = v
				}
				lcRet += lcChar
				lnPos++
				if lnPos > Len(tcValue) {
					exit
				}
			}
		}
		
		return lcRet

		
	func _process_format_for_numeric(tcValue, tcFormat, taValidChars)
	
		lcRet = tcValue
		if Len(tcFormat) > 0 {
			lcRet = ""
			lnValueDecimalPoint = this.frAt(this._decimal_point, tcValue, 1)
			lnMaskDecimalPoint = this.frAt(this._decimal_point, tcFormat, 1)
			
			/*
			 * Handle decimal portion of number
			 */
			lcDecimalRet = this._empty_char
			lcDecimalMask = this._empty_char
			lcDecimalValue = this._empty_char
			if lnMaskDecimalPoint > 0 {
				lcDecimalMask = this.frSubstr(tcFormat, lnMaskDecimalPoint, Null)
				lcIntMask = Left(tcFormat, lnMaskDecimalPoint - 1)
				lcDecimalValue = this.frReplicate("0", Len(lcDecimalMask))
			else	
				lcIntMask = tcFormat
			}
			
			if lnValueDecimalPoint > 0 {
				lcDecimalValue = this.frSubStr(tcValue, lnValueDecimalPoint, Null) + this.frReplicate("0", 19)
				lcDecimalValue = Left(lcDecimalValue, Len(lcDecimalMask))
				lcIntValue = Left(tcValue, lnValueDecimalPoint - 1)
			else
				lcIntValue = tcValue
			}
			
			/*
			 * Handle integer portion of number
			 */
			lnMaxChars = Len(lcIntValue)
			lcRet = this._empty_char
			for i = lnMaxChars to 1 step -1 {
				lcN = this.frSubStr(lcIntValue, i, 1)
				lcM = this.frSubstr(lcIntMask, i, 1)
				if IsDigit(lcN) {
					if this.frInList(lcM, taValidChars) {
						lcRet = lcN + lcRet
					else
						if lcM = this._separator {
							lcRet = lcN + this._set_separator + lcRet
						}
					}	
				else
					if lcN = this._space {
						lcRet = lcN + lcRet
					}
				}
			}
			lcRet += lcDecimalValue 
		}
		
		return lcRet
