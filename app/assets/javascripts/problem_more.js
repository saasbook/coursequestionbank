var Question = {
    setup: function() {
        $('.select_multiple_question').each(function() {
            var question = $(this);
            question.ready(function() {
                var hoverOnEntry = function() {
                    $(this).css('border', '2px solid dodgerblue');
                }
                var hoverOffEntry = function() {
                    $(this).css('border', '1px solid grey');
                }
                var unCheckAll = function(entrysDiv) {
                    $(entrysDiv).find(".entrybox").each(function() {

                        $(this).on("mouseleave", hoverOffEntry);

                        $(this).mouseleave();
                        $(this).on("mouseover", hoverOnEntry);
                    });
                }
                var clickOnEntry = function(event) {
                    target = $(event.target);
                    choice = $(this).find(":checkbox")
                    checked = choice.prop('checked');
                    if (target.is(':checkbox')) {
                        checked = !checked;
                    }
                    if (checked) {
                        $(this).on("mouseover", hoverOnEntry);
                        $(this).on("mouseleave", hoverOffEntry);
                    } else {
                        // unCheckAll($(this).parent());
                        $(this).mouseover();
                        $(this).off("mouseover");
                        $(this).off("mouseleave");
                    }
                    choice.prop('checked', !checked);
                    return;
                }

                var checkCorrect = function(checkButton) {
                    var correct = true
                    var attemptRecord = ""
                    $(this).parent().find(".entrybox").each(function () {
                        choice_correct = ($(this).attr('correct') === 'true') === $(this).find('input[type="checkbox"]').is(':checked')
                        correct = correct && choice_correct;
                        if ($(this).find('input[type="checkbox"]').is(':checked')){
                            attemptRecord =  attemptRecord + $(this).attr("answer_id");
                        }
                    })

                    $(this).parent().find(".entrybox").each(function() {

                        if ($(this).find('input[type="checkbox"]').is(':checked')){
                            $(this).find('.entryexplain').show();
                            $(this).off("mouseover");
                            $(this).off("mouseleave");
                        }else{
                            $(this).find('.entryexplain').hide();
                            $(this).on("mouseover", hoverOnEntry);
                            $(this).on("mouseleave", hoverOffEntry);
                        }

                    });
                    if (correct){
                        $(this).parent().find(".multiple-correct").show();
                        $(this).parent().find(".multiple-correct").css('border', '2px solid green');
                        $(this).parent().find(".multiple-wrong").hide();
                    }else{
                        $(this).parent().find(".multiple-wrong").css('border', '2px solid red');
                        $(this).parent().find(".multiple-correct").hide();
                        $(this).parent().find(".multiple-wrong").show();
                    }

                    problemName = $(this).parent().find("input").attr("name")

                    $.ajax({
                        url: "studentanswers",
                        type: 'POST',
                        data: {attempt: attemptRecord, problem_uid:problemName, correctness:correct}
                    });
                    return false;
                }

                var showCorrect = function (showButton) {
                    $(this).parent().find(".entrybox").each(function () {
                        if ($(this).attr('correct') === 'true'){
                            $(this).find('.entryexplain').show();
                            $(this).find('input[type = "checkbox"]').prop("checked", true);
                            $(this).css('border', '2px solid green');
                            $(this).off("mouseover");
                            $(this).off("mouseleave");
                        }else{
                            $(this).find('.entryexplain').hide();
                            $(this).find('input[type = "checkbox"]').prop("checked", false);
                            $(this).css('border', '1px solid grey');
                            $(this).on("mouseover");
                            $(this).on("mouseleave");
                        }
                    })

                }

                question.find(".show-answer").click(showCorrect);
                question.find(".entrybox").mouseover(hoverOnEntry);
                question.find(".entrybox").mouseleave(hoverOffEntry);
                question.find(".entrybox").click(clickOnEntry);
                question.find(".check-answer").click(checkCorrect);

            });

        });

        $('.multiple_choice_question').each(function() {
            var question = $(this);
            question.ready(function() {
                var hoverOnEntry = function() {
                    $(this).css('border', '2px solid dodgerblue');
                }
                var hoverOffEntry = function() {
                    $(this).css('border', '1px solid grey');
                }
                var unCheckAll = function(entrysDiv) {
                    $(entrysDiv).find(".entrybox").each(function() {
                        $(this).on("mouseover", hoverOnEntry);
                        $(this).on("mouseleave", hoverOffEntry);
                        $(this).mouseleave();
                    });
                }
                var clickOnEntry = function(event) {
                    target = $(event.target);
                    choice = $(this).find(":radio");
                    checked = $(this).find(":radio").prop('checked');
                    if (target.is(':radio')) {
                        checked = !checked;
                    }
                    if (checked) {

                        $(this).on("mouseover", hoverOnEntry);
                        $(this).on("mouseleave", hoverOffEntry);
                    } else {
                        unCheckAll($(this).parent());
                        $(this).mouseover();
                        $(this).off("mouseover");
                        $(this).off("mouseleave");
                    }

                    choice.prop('checked', !checked);
                    result = $(this).attr('correct') === 'true'
                    attemptRecord = $(this).attr("answer_id")


                }

                var checkCorrect = function(checkButton) {
                    $(this).parent().find(".entrybox").each(function() {

                        if ($(this).find('input[type="radio"]').is(':checked')){
                            $(this).find('.entryexplain').show();
                            $(this).off("mouseover");
                            $(this).off("mouseleave");
                            if ($(this).attr('correct') === 'true')
                                $(this).css('border', '2px solid green');
                            else
                                $(this).css('border', '2px solid red');
                        }else{
                            $(this).find('.entryexplain').hide();
                            $(this).on("mouseover", hoverOnEntry);
                            $(this).on("mouseleave", hoverOffEntry);
                        }

                    });
                    problemName = $(this).parent().find("input").attr("name")

                    $.ajax({
                        url: "studentanswers",
                        type: 'POST',
                        data: {attempt: attemptRecord, problem_uid:problemName, correctness:result}
                    });
                    return false;
                }


                var showCorrect = function (showButton) {
                    $(this).parent().find(".entrybox").each(function () {
                        if ($(this).attr('correct') === 'true'){
                            $(this).find('.entryexplain').show();
                            $(this).find('input[type = "checkbox"]').prop("checked", true);
                            $(this).css('border', '2px solid green');
                            $(this).off("mouseover");
                            $(this).off("mouseleave");
                        }else{
                            $(this).find('.entryexplain').hide();
                            $(this).find('input[type = "checkbox"]').prop("checked", false);
                            $(this).css('border', '1px solid grey');
                            $(this).on("mouseover");
                            $(this).on("mouseleave");
                        }
                    })

                }


                question.find(".show-answer").click(showCorrect);
                question.find(".entrybox").mouseover(hoverOnEntry);
                question.find(".entrybox").mouseleave(hoverOffEntry);
                question.find(".entrybox").click(clickOnEntry);
                question.find(".check-answer").click(checkCorrect);

                // question.find(".entrybox").mouseover(hoverOnEntry);
                // question.find(".entrybox").mouseleave(hoverOffEntry);
                // question.find(".entrybox").click(clickOnEntry);
                // question.find(".check-answer").click(checkCorrect)

            });

        });

        $('.fillin_question').each(function() {
            var question = $(this);
            question.ready(function() {

                var hoverOnEntry = function() {
                    $(this).css('border', '2px solid dodgerblue');
                }

                var checkCorrect = function(checkButton) {

                    if ($(this).parent().find(".students-answer").val().toUpperCase() === $(this).parent().find("p.answer").text().trim().toUpperCase()){
                        $(this).parent().find(".entrybox").css('border', '2px solid green');
                        $(this).parent().find(".fillin-correct").show()
                        $(this).parent().find(".fillin-wrong").hide()
                        $(this).parent().find(".fillin-showAnswer").hide()
                        result = true;
                        attemptRecord = "entry_1"
                    }else{
                        $(this).parent().find(".entrybox").css('border', '2px solid red');
                        $(this).parent().find(".fillin-correct").hide()
                        $(this).parent().find(".fillin-wrong").show()
                        $(this).parent().find(".fillin-showAnswer").hide()
                        result = false;
                        attemptRecord = "entry_2"
                    }
                    problemName = $(this).parent().find("input").attr("id")

                    $.ajax({
                        url: "studentanswers",
                        type: 'POST',
                        data: {attempt: attemptRecord, problem_uid:problemName, correctness:result}
                    });
                    return false;

                }

                var showCorrect = function (showButton) {
                    $(this).parent().find(".entrybox").css('border', '2px solid green');
                    $(this).parent().find(".fillin-showAnswer").show()
                    $(this).parent().find(".fillin-correct").hide()
                    $(this).parent().find(".fillin-wrong").hide()
                }


                question.find(".show-answer").click(showCorrect);
                question.find(".entrybox").css('border', "None")
                question.find(".check-answer").click(checkCorrect)
            });

        });

    }
};
$(Question.setup);


var ChangeCollectionsByCheckbox = {
    setup: function() {
        $('.collection-checkbox').each(function() {
            var container = $(this);
            container.click(function() {
                $.ajax({
                    url: $(this).attr('action'),
                    type: 'PUT',
                    data: {"collection": $(this).attr("collection")},
                    success: function() { // update belongs to which collecion
                        button_text = "#collection_text_" + $(this).attr("collection") + "_" + $(this).attr("problem")
                        var button = $(this).find('input[type="submit"]');
                        if ($(this).attr("checked") === "checked") {
                            $(this).attr('checked',false);
                            $(button_text).hide();
                        } else {
                            $(this).attr('checked',true);
                            $(button_text).show();
                        }
                    },
                    error: function() {
                        alert("Error: Collection not updated")
                    }
                });
                return true;
            });
        });
    }

};
$(ChangeCollectionsByCheckbox.setup);

function setupSelectMultipleQuestion() {
    var question = $(this);
    question.ready(function() {
        question.find(".show-answer").click(showCorrectAnswers);
        question.find(".entrybox").mouseover(hoverOnEntry);
        question.find(".entrybox").mouseleave(hoverOffEntry);
        question.find(".entrybox").click(multipleSelectClickOnEntry);
        question.find(".check-answer").click(checkCorrectSelectMultiple);
    });
}

function checkCorrectSelectMultiple(checkButton) {
    var correct = true, attemptRecord = "", parent = $(this).parent();
    parent.find(".entrybox").each(function () {
        choice_correct = ($(this).attr('correct') === 'true') === $(this).find('input[type="checkbox"]').is(':checked')
        correct = correct && choice_correct;
        if ($(this).find('input[type="checkbox"]').is(':checked')){
            attemptRecord =  attemptRecord + $(this).attr("answer_id");
        }
    })
    parent.find(".entrybox").each(toggleAnswers);
    var multipleCorrect = parent.find(".multiple-correct"), multipleWrong = parent.find(".multiple-wrong");
    if (correct){
        multipleCorrect.css('border', '2px solid green');
        multipleCorrect.show();
        multipleWrong.hide();
    } else {
        multipleWrong.css('border', '2px solid red');
        multipleCorrect.hide();
        multipleWrong.show();
    }
    problemName = $(this).parent().find("input").attr("name")
    $.ajax({ url: "studentanswers",
             type: 'POST',
             data: {attempt: attemptRecord, problem_uid:problemName, correctness:correct}});
    return false;
}

function showCorrectAnswers(showButton) {
    $(this).parent().find(".entrybox").each(function () {
        var correct = $(this).attr('correct') === 'true';
        $(this).find('input[type = "checkbox"]').prop("checked", correct);
        if (correct){
            $(this).find('.entryexplain').show();
            $(this).css('border', '2px solid green');
            $(this).off("mouseover");
            $(this).off("mouseleave");
        }else{
            $(this).find('.entryexplain').hide();
            $(this).css('border', '1px solid grey');
            $(this).on("mouseover");
            $(this).on("mouseleave");
        }
    })
}

function setupMultipleQuestion() {
    var question = $(this);
    question.ready(function() {
        var checkCorrect = function(checkButton) {
            $(this).parent().find(".entrybox").each(toggleAnswers);
            problemName = $(this).parent().find("input").attr("name")
            attemptRecord = $(this).attr("answer_id")
            result = $(this).attr('correct') === 'true'
            $.ajax({
                url: "studentanswers",
                type: 'POST',
                data: {attempt: attemptRecord, problem_uid:problemName, correctness:result}
            });
            return false;
        }
        question.find(".show-answer").click(showCorrectAnswers);
        question.find(".entrybox").mouseover(hoverOnEntry);
        question.find(".entrybox").mouseleave(hoverOffEntry);
        question.find(".entrybox").click(multipleQuestionClickOnEntry);
        question.find(".check-answer").click(checkCorrect);
    });
}

function setupFillinQuestion() {
    var question = $(this);
    question.ready(function() {
        var showCorrect = function (showButton) {
            $(this).parent().find(".entrybox").css('border', '2px solid green');
            $(this).parent().find(".fillin-showAnswer").show()
            $(this).parent().find(".fillin-correct").hide()
            $(this).parent().find(".fillin-wrong").hide()
        }
        question.find(".show-answer").click(showCorrect);
        question.find(".entrybox").css('border', "None")
        question.find(".check-answer").click(checkCorrectFillIn)
    });
}

function checkCorrectFillIn(checkButton) {
    var parent = $(this).parent();
    if (parent.find(".students-answer").val().toUpperCase() === parent.find("p.answer").text().trim().toUpperCase()){
        parent.find(".entrybox").css('border', '2px solid green');
        parent.find(".fillin-correct").show()
        parent.find(".fillin-wrong").hide()
        parent.find(".fillin-showAnswer").hide()
        result = true;
        attemptRecord = "entry_1"
    }else{
        parent.find(".entrybox").css('border', '2px solid red');
        parent.find(".fillin-correct").hide()
        parent.find(".fillin-wrong").show()
        parent.find(".fillin-showAnswer").hide()
        result = false;
        attemptRecord = "entry_2"
    }
    problemName = parent.find("input").attr("id")
    $.ajax({
        url: "studentanswers",
        type: 'POST',
        data: {attempt: attemptRecord, problem_uid:problemName, correctness:result}
    });
    return false;
}

function multipleSelectClickOnEntry(event) {
    target = $(event.target);
    choice = $(this).find(":checkbox")
    checked = choice.prop('checked');
    if (target.is(':checkbox')) {
        checked = !checked;
    }
    if (checked) {
        mouseOverLeaveOn();
    } else {
        $(this).mouseover();
        mouseOverLeaveOff();
    }
    choice.prop('checked', !checked);
    return;
}

function multipleQuestionClickOnEntry(event) {
    target = $(event.target);
    choice = $(this).find(":radio");
    checked = $(this).find(":radio").prop('checked');
    if (target.is(':radio')) {
        checked = !checked;
    }
    if (checked) {
        mouseOverLeaveOn();
    } else {
        uncheckAll($(this).parent());
        $(this).mouseover();
        mouseOverLeaveOff();
    }
    choice.prop('checked', !checked);
}

function uncheckAll(entrysDiv) {
    $(entrysDiv).find(".entrybox").each(function() {
        mouseOverLeaveOn();
        $(this).mouseleave();
    });
}

function toggleAnswers() {
    if ($(this).find('input[type="radio"]').is(':checked')){
        $(this).find('.entryexplain').show();
        mouseOverLeaveOff();
        if ($(this).attr('correct') === 'true')
            $(this).css('border', '2px solid green');
        else
            $(this).css('border', '2px solid red');
    }else{
        $(this).find('.entryexplain').hide();
        mouseOverLeaveOn();
    }
}

function hoverOnEntry() {
    $(this).css('border', '2px solid dodgerblue');
}

function hoverOffEntry() {
    $(this).css('border', '1px solid grey');
}

function mouseOverLeaveOff() {
    $(this).off("mouseover");
    $(this).off("mouseleave");
}

function mouseOverLeaveOn() {
    $(this).on("mouseover", hoverOnEntry);
    $(this).on("mouseleave", hoverOffEntry);
}
