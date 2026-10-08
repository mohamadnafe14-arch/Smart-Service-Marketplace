import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_service_market_place/features/chat/viewmodel/chat_cubit.dart';

class ChatComposer extends StatefulWidget {
  const ChatComposer({super.key});

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _typingDebounce;

  void _send() {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    _controller.clear();
    _typingDebounce?.cancel();
    unawaited(context.read<ChatCubit>().setTyping(false));
    unawaited(context.read<ChatCubit>().sendMessage(text));
  }

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(
      14,
      11,
      14,
      12 + MediaQuery.viewInsetsOf(context).bottom,
    ),
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: Color(0xFFEAF0EF))),
    ),
    child: SafeArea(
      top: false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              minLines: 1,
              maxLines: 5,
              maxLength: 5000,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) {
                _typingDebounce?.cancel();
                _typingDebounce = Timer(
                  const Duration(milliseconds: 350),
                  () => unawaited(context.read<ChatCubit>().setTyping(true)),
                );
              },
              onTapOutside: (_) {
                _focusNode.unfocus();
                _typingDebounce?.cancel();
                unawaited(context.read<ChatCubit>().setTyping(false));
              },
              onSubmitted: (_) => _send(),
              decoration: InputDecoration(
                hintText: 'Write a message…',
                hintStyle: const TextStyle(color: Color(0xFF9BA8A7)),
                filled: true,
                fillColor: const Color(0xFFF2F6F5),
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          SizedBox(
            width: 47,
            height: 47,
            child: FilledButton(
              onPressed: _send,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF087E78),
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
              ),
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  @override
  void dispose() {
    _typingDebounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
