
function settitle ()
{
	t="[$@]@`hostname`"
	# "\e]2;"までがウインドウタイトル変更開始の制御コード
	# "\007"が変更終了・・・らしい、です。
	echo -ne "\e]2;$t\007"
}

function popd()
{
	builtin popd "$@" && settitle `builtin pwd`
}

function pushd()
{
	builtin pushd "$@" && settitle `builtin pwd`
}

function cd()
{
	builtin cd "$@" && settitle `builtin pwd`
}

settitle `builtin pwd`

