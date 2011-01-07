        <!-- begin news -->
        <section>
            <header>
                <h2>{writeNewsHeader}{writeNewsRSS}</h2>
            </header>
            <!-- News -->
            <article>
                <header>
                    <h3>{writeHeader}</h3>
                </header>
                {writeContent}
            </article>
            <!-- /News -->

            <div id="faqTabs">
                <ul class="faqTabNav">
                    <li>
                        <a href="javascript:void(0);" onclick="infoBox('authorInfo')">
                            About this news
                        </a>
                    </li>
                </ul>
                <div class="faqTabContent" id="authorInfo" style="display: none;">
                    {writeDateMsg}<br />{writeAuthor}<br />{editThisEntry}
                </div>
            </div>

            <p>{writeCommentMsg}</p>

            <!-- Comment Form -->
            <a name="comment"></a>
            <div id="commentForm" style="display: none;">
            <form id="formValues" action="#" method="post">
                <input type="hidden" name="newsid" value="{newsId}" />
                <input type="hidden" name="lang" value="{newsLang}" />
                <input type="hidden" name="type" value="news" />

                <p>
                    <label for="user">{msgNewContentName}</label>
                    <input type="text" id="user" name="user" value="{defaultContentName}" size="50" required="required" />
                </p>

                <p>
                    <label for="mail">{msgNewContentMail}</label>
                    <input type="email" id="mail" name="mail" value="{defaultContentMail}" size="50" required="required" />
                </p>

                <p>
                    <label for="comment_text">{msgYourComment}</label>
                    <textarea cols="37" rows="10" id="comment_text" name="comment_text" required="required" /></textarea>
                </p>

                <p>
                    {captchaFieldset}
                </p>

                <p>
                    <input class="submit" id="submitComment" type="submit" value="{msgNewContentSubmit}" />
                </p>

            </form>
            </div>
            <!-- /Comment Form -->

            <div id="loader"></div>
            <div id="comments">
                {writeComments}
            </div>

            <script type="text/javascript" >
            $(function() {
                $('#submitComment').click(function() {

                    var formValues = $('#formValues');

                    $("#loader").show();
                    $("#loader").fadeIn(400).html('<img src="images/ajax-loader.gif" />Saving comment...');

                    $.ajax({
                        type:     'post',
                        url:      'ajaxservice.php?action=savecomment',
                        data:     formValues.serialize(),
                        dataType: 'json',
                        cache:    false,
                        success: function(json) {
                            if (json.success == undefined) {
                                $("#comments").html('<p class="error">' + json.error + '</p>');
                                $("#loader").hide();
                            } else {
                                $("#comments").html('<p class="success">' + json.success + '</p>');
                                $("#comments").fadeIn("slow");
                                $("#loader").hide();
                                $('#commentForm').hide();
                                // @todo add reload of #comments
                            }
                        }
                    });

                    return false;
                });
            });
            </script>

        </section>